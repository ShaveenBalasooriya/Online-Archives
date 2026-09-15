import 'package:fpdart/fpdart.dart';
import 'package:online_archive/core/error/exceptions.dart';
import 'package:online_archive/core/error/failure.dart';
import 'package:online_archive/features/books/data/datasources/book_local_datasource.dart';
import 'package:online_archive/features/books/data/models/book_model.dart';
import 'package:online_archive/features/borrowings/data/datasources/borrowing_local_datasource.dart';
import 'package:online_archive/features/borrowings/data/models/borrowing_model.dart';
import 'package:online_archive/features/borrowings/domain/entities/borrowing.dart';
import 'package:online_archive/features/borrowings/domain/entities/enums/borrowing_status.dart';
import 'package:online_archive/features/borrowings/domain/repositories/borrowing_repository.dart';
import 'package:online_archive/features/members/data/datasources/member_local_datasource.dart';
import 'package:online_archive/features/members/data/models/member_model.dart';
import 'package:uuid/uuid.dart';

/// Members can have at most this many concurrent Borrowed/Overdue
/// borrowings — mirrors `Borrowing.MaxActiveBorrowingsReached`.
const _maxActiveBorrowings = 3;

class BorrowingRepositoryImpl implements BorrowingRepository {
  const BorrowingRepositoryImpl(
    this._localDataSource,
    this._memberLocalDataSource,
    this._bookLocalDataSource,
  );

  final BorrowingLocalDataSource _localDataSource;
  final MemberLocalDataSource _memberLocalDataSource;
  final BookLocalDataSource _bookLocalDataSource;

  @override
  Future<Either<Failure, String>> createBorrowing({
    required String bookId,
    required String memberId,
  }) async {
    final MemberModel member;
    try {
      member = await _memberLocalDataSource.getMemberById(memberId);
    } on NotFoundException catch (error) {
      return Left(
        Failure(
          code: 'Member.NotFound',
          message: error.message,
          statusCode: 404,
        ),
      );
    }

    final BookModel book;
    try {
      book = await _bookLocalDataSource.getBookById(bookId);
    } on NotFoundException catch (error) {
      return Left(
        Failure(code: 'Book.NotFound', message: error.message, statusCode: 404),
      );
    }

    if (!member.isActive) {
      return Left(
        Failure(
          code: 'Member.NotActive',
          message: "Member with ID '$memberId' is not active.",
          statusCode: 403,
        ),
      );
    }

    final existingBorrowings = await _localDataSource.getBorrowingsByMember(
      memberId,
    );
    final activeCount = existingBorrowings
        .where(
          (borrowing) =>
              borrowing.status == BorrowingStatus.borrowed ||
              borrowing.status == BorrowingStatus.overdue,
        )
        .length;
    if (activeCount >= _maxActiveBorrowings) {
      return Left(
        Failure(
          code: 'Borrowing.MaxActiveBorrowingsReached',
          message:
              "Member with ID '$memberId' already has $_maxActiveBorrowings active borrowings.",
          statusCode: 409,
        ),
      );
    }

    if (book.availableCopies <= 0) {
      return Left(
        Failure(
          code: 'BookCopies.NoAvailableCopies',
          message: "Book with ID '$bookId' has no available copies.",
          statusCode: 409,
        ),
      );
    }

    final borrowedDate = DateTime.now();
    final borrowing = BorrowingModel(
      id: const Uuid().v7(),
      bookId: bookId,
      memberId: memberId,
      borrowedDate: borrowedDate,
      dueDate: borrowedDate.add(const Duration(days: 14)),
      returnedDate: null,
      status: BorrowingStatus.borrowed,
    );

    await _bookLocalDataSource.adjustAvailableCopies(bookId, -1);
    await _localDataSource.createBorrowing(borrowing);

    return Right(borrowing.id);
  }

  @override
  Future<Either<Failure, List<Borrowing>>> getBorrowingsByMember(
    String memberId,
  ) async {
    try {
      // Mirrors GET /api/borrowings/member/{memberId}: 404s if the member
      // doesn't exist before returning their (possibly empty) borrowing list.
      await _memberLocalDataSource.getMemberById(memberId);
    } on NotFoundException catch (error) {
      return Left(
        Failure(
          code: 'Member.NotFound',
          message: error.message,
          statusCode: 404,
        ),
      );
    }

    final borrowings = await _localDataSource.getBorrowingsByMember(memberId);
    return Right(borrowings);
  }

  @override
  Future<Either<Failure, Unit>> returnBorrowing(String borrowingId) async {
    final BorrowingModel borrowing;
    try {
      borrowing = await _localDataSource.getBorrowingById(borrowingId);
    } on NotFoundException catch (error) {
      return Left(
        Failure(
          code: 'Borrowing.NotFound',
          message: error.message,
          statusCode: 404,
        ),
      );
    }

    if (borrowing.status == BorrowingStatus.returned) {
      return Left(
        Failure(
          code: 'Borrowing.AlreadyReturned',
          message:
              "Borrowing with ID '$borrowingId' has already been returned.",
          statusCode: 409,
        ),
      );
    }

    try {
      await _bookLocalDataSource.adjustAvailableCopies(borrowing.bookId, 1);
    } on NotFoundException catch (error) {
      return Left(
        Failure(code: 'Book.NotFound', message: error.message, statusCode: 404),
      );
    }

    await _localDataSource.updateBorrowing(
      BorrowingModel(
        id: borrowing.id,
        bookId: borrowing.bookId,
        memberId: borrowing.memberId,
        borrowedDate: borrowing.borrowedDate,
        dueDate: borrowing.dueDate,
        returnedDate: DateTime.now(),
        status: BorrowingStatus.returned,
      ),
    );

    return const Right(unit);
  }

  @override
  Future<Either<Failure, int>> markOverdue() async {
    final count = await _localDataSource.markOverdue();
    return Right(count);
  }
}
