import 'package:fpdart/fpdart.dart';
import 'package:online_archive/core/error/exceptions.dart';
import 'package:online_archive/core/error/failure.dart';
import 'package:online_archive/features/members/data/datasources/member_local_datasource.dart';
import 'package:online_archive/features/members/data/models/member_model.dart';
import 'package:online_archive/features/members/domain/entities/member.dart';
import 'package:online_archive/features/members/domain/repositories/member_repository.dart';

class MemberRepositoryImpl implements MemberRepository {
  const MemberRepositoryImpl(this._localDataSource);

  final MemberLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, Member>> getMemberById(String id) async {
    try {
      final member = await _localDataSource.getMemberById(id);
      return Right(member);
    } on NotFoundException catch (error) {
      return Left(_notFoundFailure(error));
    } catch (error) {
      return Left(_unexpectedFailure(error));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateMember({
    required String id,
    required String fullName,
    required String? phoneNumber,
  }) async {
    try {
      // Only fullName/phoneNumber are client-editable; everything else is
      // carried over from the stored record, mirroring PUT /api/members/{id}.
      final existing = await _localDataSource.getMemberById(id);
      final updated = MemberModel(
        id: existing.id,
        fullName: fullName,
        email: existing.email,
        phoneNumber: phoneNumber,
        registeredDate: existing.registeredDate,
        isActive: existing.isActive,
        password: existing.password,
      );
      await _localDataSource.updateMember(updated);
      return const Right(unit);
    } on NotFoundException catch (error) {
      return Left(_notFoundFailure(error));
    } catch (error) {
      return Left(_unexpectedFailure(error));
    }
  }

  Failure _notFoundFailure(NotFoundException error) {
    return Failure(
      code: 'Member.NotFound',
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
