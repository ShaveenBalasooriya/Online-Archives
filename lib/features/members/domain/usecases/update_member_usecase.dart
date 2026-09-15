import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:online_archive/core/error/failure.dart';
import 'package:online_archive/core/usecases/usecase.dart';
import 'package:online_archive/features/members/domain/repositories/member_repository.dart';

class UpdateMemberUsecase implements UseCase<Unit, UpdateMemberParams> {
  const UpdateMemberUsecase(this._repository);

  final MemberRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(UpdateMemberParams params) {
    return _repository.updateMember(
      id: params.id,
      fullName: params.fullName,
      phoneNumber: params.phoneNumber,
    );
  }
}

class UpdateMemberParams extends Equatable {
  const UpdateMemberParams({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
  });

  final String id;
  final String fullName;
  final String? phoneNumber;

  @override
  List<Object?> get props => [id, fullName, phoneNumber];
}
