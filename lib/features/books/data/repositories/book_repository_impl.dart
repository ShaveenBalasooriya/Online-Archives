import 'package:fpdart/fpdart.dart';
import 'package:online_archive/core/error/exceptions.dart';
import 'package:online_archive/core/error/failure.dart';
import 'package:online_archive/features/books/data/datasources/book_local_datasource.dart';
import 'package:online_archive/features/books/data/models/book_model.dart';
import 'package:online_archive/features/books/domain/entities/book.dart';
import 'package:online_archive/features/books/domain/repositories/book_repository.dart';
import 'package:uuid/uuid.dart';

class BookRepositoryImpl implements BookRepository {
  const BookRepositoryImpl(this._localDataSource);

  final BookLocalDataSource _localDataSource;

  static const _uuid = Uuid();

  @override
  Future<Either<Failure, String>> createBook({
    required String title,
    required String author,
    required String isbn,
    required int publishedYear,
    required int totalCopies,
  }) async {
    final books = await _localDataSource.getBooks();
    final isDuplicateIsbn = books.any((book) => book.isbn == isbn);
    if (isDuplicateIsbn) {
      return Left(
        Failure(
          code: 'Book.DuplicateIsbn',
          message: "A book with ISBN '$isbn' already exists.",
          statusCode: 409,
        ),
      );
    }

    final id = _uuid.v7();
    final model = BookModel(
      id: id,
      title: title,
      author: author,
      isbn: isbn,
      publishedYear: publishedYear,
      totalCopies: totalCopies,
      availableCopies: totalCopies,
      // The create request carries neither — the backend has no such fields.
      coverImageUrl: null,
      description: null,
    );

    try {
      await _localDataSource.createBook(model);
      return Right(id);
    } catch (error) {
      return Left(_unexpectedFailure(error));
    }
  }

  @override
  Future<Either<Failure, Book>> getBookById(String id) async {
    try {
      final book = await _localDataSource.getBookById(id);
      return Right(book);
    } on NotFoundException catch (error) {
      return Left(_notFoundFailure(error));
    } catch (error) {
      return Left(_unexpectedFailure(error));
    }
  }

  @override
  Future<Either<Failure, List<Book>>> getAllBooks() async {
    try {
      final books = await _localDataSource.getBooks();
      return Right(books);
    } catch (error) {
      return Left(_unexpectedFailure(error));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateBook({
    required String id,
    required String title,
    required String author,
    required String isbn,
    required int publishedYear,
    required int totalCopies,
  }) async {
    final BookModel existing;
    try {
      existing = await _localDataSource.getBookById(id);
    } on NotFoundException catch (error) {
      return Left(_notFoundFailure(error));
    }

    final books = await _localDataSource.getBooks();
    final isDuplicateIsbn = books.any(
      (book) => book.id != id && book.isbn == isbn,
    );
    if (isDuplicateIsbn) {
      return Left(
        Failure(
          code: 'Book.DuplicateIsbn',
          message: "A book with ISBN '$isbn' already exists.",
          statusCode: 409,
        ),
      );
    }

    // Mirrors the backend: totalCopies can't drop below what's currently
    // borrowed. Until the Borrowings feature exists, "borrowed" is derived
    // from this book's own record (totalCopies - availableCopies).
    final borrowedCount = existing.totalCopies - existing.availableCopies;
    if (totalCopies < borrowedCount) {
      return Left(
        Failure(
          code: 'BookCopies.ReduceBelowBorrowed',
          message:
              'Cannot reduce total copies below the number currently '
              'borrowed ($borrowedCount).',
          statusCode: 409,
        ),
      );
    }

    final updated = BookModel(
      id: id,
      title: title,
      author: author,
      isbn: isbn,
      publishedYear: publishedYear,
      totalCopies: totalCopies,
      availableCopies: totalCopies - borrowedCount,
      coverImageUrl: existing.coverImageUrl,
      description: existing.description,
    );

    try {
      await _localDataSource.updateBook(updated);
      return const Right(unit);
    } catch (error) {
      return Left(_unexpectedFailure(error));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteBook(String id) async {
    // Note: the backend also rejects deletion with 409 Book.HasActiveBorrowings
    // when the book has active borrowings — not enforced here yet since the
    // Borrowings feature doesn't exist.
    try {
      await _localDataSource.deleteBook(id);
      return const Right(unit);
    } on NotFoundException catch (error) {
      return Left(_notFoundFailure(error));
    } catch (error) {
      return Left(_unexpectedFailure(error));
    }
  }

  Failure _notFoundFailure(NotFoundException error) {
    return Failure(
      code: 'Book.NotFound',
      message: error.message,
      statusCode: 404,
    );
  }

  Failure _unexpectedFailure(Object error) {
    return Failure(
      code: 'Unexpected',
      message: error.toString(),
      statusCode: 500,
    );
  }
}
