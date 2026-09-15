import 'package:fpdart/fpdart.dart';
import 'package:online_archive/core/error/failure.dart';
import 'package:online_archive/features/borrowings/domain/entities/borrowing.dart';

/// Contract for reading and mutating [Borrowing]s.
abstract interface class BorrowingRepository {
  Future<Either<Failure, String>> createBorrowing({
    required String bookId,
    required String memberId,
  });

  Future<Either<Failure, List<Borrowing>>> getBorrowingsByMember(
    String memberId,
  );

  Future<Either<Failure, Unit>> returnBorrowing(String borrowingId);

  Future<Either<Failure, int>> markOverdue();
}
