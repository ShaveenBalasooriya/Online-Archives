import 'package:fpdart/fpdart.dart';
import 'package:online_archive/core/error/failure.dart';
import 'package:online_archive/core/usecases/usecase.dart';
import 'package:online_archive/features/borrowings/domain/entities/borrowing.dart';
import 'package:online_archive/features/borrowings/domain/repositories/borrowing_repository.dart';

/// Fetches every borrowing for a member. Mirrors
/// `GET /api/borrowings/member/{memberId}`.
class GetBorrowingsByMemberUsecase implements UseCase<List<Borrowing>, String> {
  const GetBorrowingsByMemberUsecase(this._repository);

  final BorrowingRepository _repository;

  @override
  Future<Either<Failure, List<Borrowing>>> call(String memberId) {
    return _repository.getBorrowingsByMember(memberId);
  }
}
