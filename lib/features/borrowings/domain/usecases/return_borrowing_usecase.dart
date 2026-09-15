import 'package:fpdart/fpdart.dart';
import 'package:online_archive/core/error/failure.dart';
import 'package:online_archive/core/usecases/usecase.dart';
import 'package:online_archive/features/borrowings/domain/repositories/borrowing_repository.dart';

/// Returns a borrowing. Mirrors `POST /api/borrowings/{id}/return`.
class ReturnBorrowingUsecase implements UseCase<Unit, String> {
  const ReturnBorrowingUsecase(this._repository);

  final BorrowingRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(String borrowingId) {
    return _repository.returnBorrowing(borrowingId);
  }
}
