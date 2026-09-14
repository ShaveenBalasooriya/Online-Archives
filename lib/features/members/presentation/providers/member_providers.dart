import 'package:online_archive/features/members/data/repositories/member_repository_impl.dart';
import 'package:online_archive/features/members/domain/usecases/get_member_by_id_usecase.dart';
import 'package:online_archive/features/members/domain/usecases/update_member_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/member_local_datasource.dart';
import '../../domain/repositories/member_repository.dart';

part 'member_providers.g.dart';

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
