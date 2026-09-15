// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(currentMemberId)
final currentMemberIdProvider = CurrentMemberIdProvider._();

final class CurrentMemberIdProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  CurrentMemberIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentMemberIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentMemberIdHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return currentMemberId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$currentMemberIdHash() => r'dee649e096c1fa3c2181ebe515b07f622537a368';

@ProviderFor(memberLocalDataSource)
final memberLocalDataSourceProvider = MemberLocalDataSourceProvider._();

final class MemberLocalDataSourceProvider
    extends
        $FunctionalProvider<
          MemberLocalDataSource,
          MemberLocalDataSource,
          MemberLocalDataSource
        >
    with $Provider<MemberLocalDataSource> {
  MemberLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'memberLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$memberLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<MemberLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MemberLocalDataSource create(Ref ref) {
    return memberLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MemberLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MemberLocalDataSource>(value),
    );
  }
}

String _$memberLocalDataSourceHash() =>
    r'fec128f0b8ae36af4855496dbb0ca261397f400b';

@ProviderFor(memberRepository)
final memberRepositoryProvider = MemberRepositoryProvider._();

final class MemberRepositoryProvider
    extends
        $FunctionalProvider<
          MemberRepository,
          MemberRepository,
          MemberRepository
        >
    with $Provider<MemberRepository> {
  MemberRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'memberRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$memberRepositoryHash();

  @$internal
  @override
  $ProviderElement<MemberRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MemberRepository create(Ref ref) {
    return memberRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MemberRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MemberRepository>(value),
    );
  }
}

String _$memberRepositoryHash() => r'94809098d95195adffef05cef9f9ebdcdca161d1';

@ProviderFor(getMemberById)
final getMemberByIdProvider = GetMemberByIdProvider._();

final class GetMemberByIdProvider
    extends
        $FunctionalProvider<
          GetMemberByIdUsecase,
          GetMemberByIdUsecase,
          GetMemberByIdUsecase
        >
    with $Provider<GetMemberByIdUsecase> {
  GetMemberByIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getMemberByIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getMemberByIdHash();

  @$internal
  @override
  $ProviderElement<GetMemberByIdUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetMemberByIdUsecase create(Ref ref) {
    return getMemberById(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetMemberByIdUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetMemberByIdUsecase>(value),
    );
  }
}

String _$getMemberByIdHash() => r'f04527f0b9070ad9effd65e9b2c7bf2f07e43c5f';

@ProviderFor(updateMember)
final updateMemberProvider = UpdateMemberProvider._();

final class UpdateMemberProvider
    extends
        $FunctionalProvider<
          UpdateMemberUsecase,
          UpdateMemberUsecase,
          UpdateMemberUsecase
        >
    with $Provider<UpdateMemberUsecase> {
  UpdateMemberProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateMemberProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateMemberHash();

  @$internal
  @override
  $ProviderElement<UpdateMemberUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateMemberUsecase create(Ref ref) {
    return updateMember(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateMemberUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateMemberUsecase>(value),
    );
  }
}

String _$updateMemberHash() => r'b58b1c4724f22008157622dbeea3930fd7116b79';

@ProviderFor(memberDetails)
final memberDetailsProvider = MemberDetailsFamily._();

final class MemberDetailsProvider
    extends $FunctionalProvider<AsyncValue<Member>, Member, FutureOr<Member>>
    with $FutureModifier<Member>, $FutureProvider<Member> {
  MemberDetailsProvider._({
    required MemberDetailsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'memberDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$memberDetailsHash();

  @override
  String toString() {
    return r'memberDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Member> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Member> create(Ref ref) {
    final argument = this.argument as String;
    return memberDetails(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MemberDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$memberDetailsHash() => r'3aebf9775084c6c9c73aa2d0eab24eb42f249190';

final class MemberDetailsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Member>, String> {
  MemberDetailsFamily._()
    : super(
        retry: null,
        name: r'memberDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MemberDetailsProvider call(String memberId) =>
      MemberDetailsProvider._(argument: memberId, from: this);

  @override
  String toString() => r'memberDetailsProvider';
}
