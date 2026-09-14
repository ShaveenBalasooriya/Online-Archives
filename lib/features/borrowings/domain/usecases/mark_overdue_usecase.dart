import 'package:fpdart/fpdart.dart';
import 'package:online_archive/core/error/failure.dart';
import 'package:online_archive/core/usecases/usecase.dart';
import 'package:online_archive/features/borrowings/domain/repositories/borrowing_repository.dart';

/// Flips overdue borrowings and returns the count flipped. Mirrors
/// `POST /api/borrowings/mark-overdue`.
class MarkOverdueUsecase implements UseCase<int, NoParams> {
  const MarkOverdueUsecase(this._repository);

  final BorrowingRepository _repository;

  @override
  Future<Either<Failure, int>> call(NoParams params) {
    return _repository.markOverdue();
  }
}
