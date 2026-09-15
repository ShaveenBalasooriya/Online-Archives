import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:online_archive/core/error/failure.dart';
import 'package:online_archive/core/usecases/usecase.dart';
import 'package:online_archive/features/borrowings/domain/repositories/borrowing_repository.dart';

/// Creates a new borrowing. Mirrors `POST /api/borrowings`.
class CreateBorrowingUsecase implements UseCase<String, CreateBorrowingParams> {
  const CreateBorrowingUsecase(this._repository);

  final BorrowingRepository _repository;

  @override
  Future<Either<Failure, String>> call(CreateBorrowingParams params) {
    return _repository.createBorrowing(
      bookId: params.bookId,
      memberId: params.memberId,
    );
  }
}

class CreateBorrowingParams extends Equatable {
  const CreateBorrowingParams({required this.bookId, required this.memberId});

  final String bookId;
  final String memberId;

  @override
  List<Object?> get props => [bookId, memberId];
}
