// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bookLocalDataSource)
final bookLocalDataSourceProvider = BookLocalDataSourceProvider._();

final class BookLocalDataSourceProvider
    extends
        $FunctionalProvider<
          BookLocalDataSource,
          BookLocalDataSource,
          BookLocalDataSource
        >
    with $Provider<BookLocalDataSource> {
  BookLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<BookLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BookLocalDataSource create(Ref ref) {
    return bookLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BookLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BookLocalDataSource>(value),
    );
  }
}

String _$bookLocalDataSourceHash() =>
    r'70829ea88a636f44ec268e7e679e7aae4c81023c';

@ProviderFor(bookRepository)
final bookRepositoryProvider = BookRepositoryProvider._();

final class BookRepositoryProvider
    extends $FunctionalProvider<BookRepository, BookRepository, BookRepository>
    with $Provider<BookRepository> {
  BookRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookRepositoryHash();

  @$internal
  @override
  $ProviderElement<BookRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BookRepository create(Ref ref) {
    return bookRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BookRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BookRepository>(value),
    );
  }
}

String _$bookRepositoryHash() => r'0ca4554d214fab4218d9eafc2553883dafc7874a';

@ProviderFor(getAllBooks)
final getAllBooksProvider = GetAllBooksProvider._();

final class GetAllBooksProvider
    extends $FunctionalProvider<GetAllBooks, GetAllBooks, GetAllBooks>
    with $Provider<GetAllBooks> {
  GetAllBooksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAllBooksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAllBooksHash();

  @$internal
  @override
  $ProviderElement<GetAllBooks> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetAllBooks create(Ref ref) {
    return getAllBooks(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetAllBooks value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetAllBooks>(value),
    );
  }
}

String _$getAllBooksHash() => r'3e3ea27ed41c490e36f70c628afdb4a8fd24f588';

@ProviderFor(getBookById)
final getBookByIdProvider = GetBookByIdProvider._();

final class GetBookByIdProvider
    extends $FunctionalProvider<GetBookById, GetBookById, GetBookById>
    with $Provider<GetBookById> {
  GetBookByIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getBookByIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getBookByIdHash();

  @$internal
  @override
  $ProviderElement<GetBookById> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetBookById create(Ref ref) {
    return getBookById(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetBookById value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetBookById>(value),
    );
  }
}

String _$getBookByIdHash() => r'c7ba2b8a3f09b63c5fb1403d15427f30732905c4';

@ProviderFor(searchBooks)
final searchBooksProvider = SearchBooksProvider._();

final class SearchBooksProvider
    extends $FunctionalProvider<SearchBooks, SearchBooks, SearchBooks>
    with $Provider<SearchBooks> {
  SearchBooksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchBooksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchBooksHash();

  @$internal
  @override
  $ProviderElement<SearchBooks> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SearchBooks create(Ref ref) {
    return searchBooks(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchBooks value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchBooks>(value),
    );
  }
}

String _$searchBooksHash() => r'ab08c13e13f98f34acc1de8221f44d0cc04b3d94';

@ProviderFor(booksList)
final booksListProvider = BooksListProvider._();

final class BooksListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Book>>,
          List<Book>,
          FutureOr<List<Book>>
        >
    with $FutureModifier<List<Book>>, $FutureProvider<List<Book>> {
  BooksListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'booksListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$booksListHash();

  @$internal
  @override
  $FutureProviderElement<List<Book>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Book>> create(Ref ref) {
    return booksList(ref);
  }
}

String _$booksListHash() => r'1ef3290c28bc78fccca1454d60d7d12c02169000';

@ProviderFor(bookDetails)
final bookDetailsProvider = BookDetailsFamily._();

final class BookDetailsProvider
    extends $FunctionalProvider<AsyncValue<Book>, Book, FutureOr<Book>>
    with $FutureModifier<Book>, $FutureProvider<Book> {
  BookDetailsProvider._({
    required BookDetailsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'bookDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bookDetailsHash();

  @override
  String toString() {
    return r'bookDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Book> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Book> create(Ref ref) {
    final argument = this.argument as String;
    return bookDetails(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BookDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bookDetailsHash() => r'39c4c7e55d6f0f53288a86edba8d656e65ce2294';

final class BookDetailsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Book>, String> {
  BookDetailsFamily._()
    : super(
        retry: null,
        name: r'bookDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BookDetailsProvider call(String bookId) =>
      BookDetailsProvider._(argument: bookId, from: this);

  @override
  String toString() => r'bookDetailsProvider';
}

@ProviderFor(bookSearchResults)
final bookSearchResultsProvider = BookSearchResultsFamily._();

final class BookSearchResultsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Book>>,
          List<Book>,
          FutureOr<List<Book>>
        >
    with $FutureModifier<List<Book>>, $FutureProvider<List<Book>> {
  BookSearchResultsProvider._({
    required BookSearchResultsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'bookSearchResultsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bookSearchResultsHash();

  @override
  String toString() {
    return r'bookSearchResultsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Book>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Book>> create(Ref ref) {
    final argument = this.argument as String;
    return bookSearchResults(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BookSearchResultsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bookSearchResultsHash() => r'9cd256144ee0ec782c1393278f0c42cb447298e0';

final class BookSearchResultsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Book>>, String> {
  BookSearchResultsFamily._()
    : super(
        retry: null,
        name: r'bookSearchResultsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BookSearchResultsProvider call(String query) =>
      BookSearchResultsProvider._(argument: query, from: this);

  @override
  String toString() => r'bookSearchResultsProvider';
}
