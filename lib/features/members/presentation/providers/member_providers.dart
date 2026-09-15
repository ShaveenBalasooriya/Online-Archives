import 'package:online_archive/features/members/data/repositories/member_repository_impl.dart';
import 'package:online_archive/features/members/domain/entities/member.dart';
import 'package:online_archive/features/members/domain/usecases/get_member_by_id_usecase.dart';
import 'package:online_archive/features/members/domain/usecases/update_member_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/member_local_datasource.dart';
import '../../domain/repositories/member_repository.dart';

part 'member_providers.g.dart';

const _currentMemberId = '018f2f3a-1b1e-7c3a-8b1a-100000000001';

@riverpod
String currentMemberId(Ref ref) => _currentMemberId;

@Riverpod(keepAlive: true)
MemberLocalDataSource memberLocalDataSource(Ref ref) {
  return MemberLocalDataSourceImpl();
}

@riverpod
MemberRepository memberRepository(Ref ref) {
  return MemberRepositoryImpl(ref.watch(memberLocalDataSourceProvider));
}

@riverpod
GetMemberByIdUsecase getMemberById(Ref ref) {
  return GetMemberByIdUsecase(ref.watch(memberRepositoryProvider));
}

@riverpod
UpdateMemberUsecase updateMember(Ref ref) {
  return UpdateMemberUsecase(ref.watch(memberRepositoryProvider));
}

@riverpod
Future<Member> memberDetails(Ref ref, String memberId) async {
  final getMemberById = ref.watch(getMemberByIdProvider);
  final result = await getMemberById(memberId);

  return result.match(
    (failure) => throw MemberDetailsException(failure.message),
    (member) => member,
  );
}

class MemberDetailsException implements Exception {
  const MemberDetailsException(this.message);

  final String message;

  @override
  String toString() => message;
}
