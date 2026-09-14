// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'borrowing_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(borrowingLocalDataSource)
final borrowingLocalDataSourceProvider = BorrowingLocalDataSourceProvider._();

final class BorrowingLocalDataSourceProvider
    extends
        $FunctionalProvider<
          BorrowingLocalDataSource,
          BorrowingLocalDataSource,
          BorrowingLocalDataSource
        >
    with $Provider<BorrowingLocalDataSource> {
  BorrowingLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'borrowingLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$borrowingLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<BorrowingLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BorrowingLocalDataSource create(Ref ref) {
    return borrowingLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BorrowingLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BorrowingLocalDataSource>(value),
    );
  }
}

String _$borrowingLocalDataSourceHash() =>
    r'711504c5673beafeb88d4456831521c8efcc8cf5';

@ProviderFor(borrowingRepository)
final borrowingRepositoryProvider = BorrowingRepositoryProvider._();

final class BorrowingRepositoryProvider
    extends
        $FunctionalProvider<
          BorrowingRepository,
          BorrowingRepository,
          BorrowingRepository
        >
    with $Provider<BorrowingRepository> {
  BorrowingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'borrowingRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$borrowingRepositoryHash();

  @$internal
  @override
  $ProviderElement<BorrowingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BorrowingRepository create(Ref ref) {
    return borrowingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BorrowingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BorrowingRepository>(value),
    );
  }
}

String _$borrowingRepositoryHash() =>
    r'f507b8adb0daf2f0a717b555916ec5361baab13d';

@ProviderFor(createBorrowing)
final createBorrowingProvider = CreateBorrowingProvider._();

final class CreateBorrowingProvider
    extends
        $FunctionalProvider<
          CreateBorrowingUsecase,
          CreateBorrowingUsecase,
          CreateBorrowingUsecase
        >
    with $Provider<CreateBorrowingUsecase> {
  CreateBorrowingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createBorrowingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createBorrowingHash();

  @$internal
  @override
  $ProviderElement<CreateBorrowingUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CreateBorrowingUsecase create(Ref ref) {
    return createBorrowing(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateBorrowingUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateBorrowingUsecase>(value),
    );
  }
}

String _$createBorrowingHash() => r'5820583fbfb2096ced8c4b2b643478a276d29807';

@ProviderFor(getBorrowingsByMember)
final getBorrowingsByMemberProvider = GetBorrowingsByMemberProvider._();

final class GetBorrowingsByMemberProvider
    extends
        $FunctionalProvider<
          GetBorrowingsByMemberUsecase,
          GetBorrowingsByMemberUsecase,
          GetBorrowingsByMemberUsecase
        >
    with $Provider<GetBorrowingsByMemberUsecase> {
  GetBorrowingsByMemberProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getBorrowingsByMemberProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getBorrowingsByMemberHash();

  @$internal
  @override
  $ProviderElement<GetBorrowingsByMemberUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetBorrowingsByMemberUsecase create(Ref ref) {
    return getBorrowingsByMember(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetBorrowingsByMemberUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetBorrowingsByMemberUsecase>(value),
    );
  }
}

String _$getBorrowingsByMemberHash() =>
    r'c7ceb1e524d4320539793a61a617f52a438dd1cb';

@ProviderFor(returnBorrowing)
final returnBorrowingProvider = ReturnBorrowingProvider._();

final class ReturnBorrowingProvider
    extends
        $FunctionalProvider<
          ReturnBorrowingUsecase,
          ReturnBorrowingUsecase,
          ReturnBorrowingUsecase
        >
    with $Provider<ReturnBorrowingUsecase> {
  ReturnBorrowingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'returnBorrowingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$returnBorrowingHash();

  @$internal
  @override
  $ProviderElement<ReturnBorrowingUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReturnBorrowingUsecase create(Ref ref) {
    return returnBorrowing(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReturnBorrowingUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReturnBorrowingUsecase>(value),
    );
  }
}

String _$returnBorrowingHash() => r'9887bc30102a025377a7e4916ba8527805c58d7e';

@ProviderFor(markOverdue)
final markOverdueProvider = MarkOverdueProvider._();

final class MarkOverdueProvider
    extends
        $FunctionalProvider<
          MarkOverdueUsecase,
          MarkOverdueUsecase,
          MarkOverdueUsecase
        >
    with $Provider<MarkOverdueUsecase> {
  MarkOverdueProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'markOverdueProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$markOverdueHash();

  @$internal
  @override
  $ProviderElement<MarkOverdueUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MarkOverdueUsecase create(Ref ref) {
    return markOverdue(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MarkOverdueUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MarkOverdueUsecase>(value),
    );
  }
}

String _$markOverdueHash() => r'254f460b80aefdf06c1ad3f017b4cb3922bdba6a';
