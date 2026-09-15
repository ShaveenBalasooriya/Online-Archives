import 'package:fpdart/fpdart.dart';
import 'package:online_archive/core/error/failure.dart';
import 'package:online_archive/core/usecases/usecase.dart';
import 'package:online_archive/features/members/domain/entities/member.dart';
import 'package:online_archive/features/members/domain/repositories/member_repository.dart';

/// Fetches a single member by id. Mirrors `GET /api/members/{id}`.
class GetMemberByIdUsecase implements UseCase<Member, String> {
  const GetMemberByIdUsecase(this._repository);

  final MemberRepository _repository;

  @override
  Future<Either<Failure, Member>> call(String id) {
    return _repository.getMemberById(id);
  }
}
