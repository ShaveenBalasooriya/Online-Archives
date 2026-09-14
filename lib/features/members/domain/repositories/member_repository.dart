import 'package:fpdart/fpdart.dart';
import 'package:online_archive/core/error/failure.dart';
import 'package:online_archive/features/members/domain/entities/member.dart';

abstract interface class MemberRepository {
  Future<Either<Failure, Member>> getMemberById(String id);

  Future<Either<Failure, Unit>> updateMember({
    required String id,
    required String fullName,
    required String? phoneNumber,
  });
}
