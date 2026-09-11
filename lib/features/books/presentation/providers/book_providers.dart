import 'package:online_archive/core/usecases/usecase.dart';
import 'package:online_archive/features/books/data/datasources/book_local_datasource.dart';
import 'package:online_archive/features/books/domain/entities/book.dart';
import 'package:online_archive/features/books/domain/repositories/book_repository.dart';
import 'package:online_archive/features/books/domain/usecases/get_all_books.dart';
import 'package:online_archive/features/books/domain/usecases/get_book_by_id.dart';
import 'package:online_archive/features/books/domain/usecases/search_books.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/book_repository_impl.dart';

part 'book_providers.g.dart';

@Riverpod(keepAlive: true)
BookLocalDataSource bookLocalDataSource(Ref ref) {
  return BookLocalDataSourceImpl();
}

@riverpod
BookRepository bookRepository(Ref ref) {
  return BookRepositoryImpl(ref.watch(bookLocalDataSourceProvider));
}

@riverpod
GetAllBooks getAllBooks(Ref ref) {
  return GetAllBooks(ref.watch(bookRepositoryProvider));
}

@riverpod
GetBookById getBookById(Ref ref) {
  return GetBookById(ref.watch(bookRepositoryProvider));
}

@riverpod
SearchBooks searchBooks(Ref ref) {
  return SearchBooks(ref.watch(bookRepositoryProvider));
}

@riverpod
Future<List<Book>> booksList(Ref ref) async {
  await Future<void>.delayed(const Duration(seconds: 2));

  final getAllBooks = ref.watch(getAllBooksProvider);
  final result = await getAllBooks(const NoParams());

  return result.match(
    (failure) => throw BooksLoadException(failure.message),
    (books) => books,
  );
}

@riverpod
Future<Book> bookDetails(Ref ref, String bookId) async {
  await Future<void>.delayed(const Duration(seconds: 1));

  final getBookById = ref.watch(getBookByIdProvider);
  final result = await getBookById(bookId);

  return result.match(
    (failure) => throw BookDetailsException(failure.message),
    (book) => book,
  );
}

@riverpod
Future<List<Book>> bookSearchResults(Ref ref, String query) async {
  await Future<void>.delayed(const Duration(milliseconds: 500));

  final searchBooks = ref.watch(searchBooksProvider);
  final result = await searchBooks(query);

  return result.match(
    (failure) => throw BookSearchException(failure.message),
    (books) => books,
  );
}

class BooksLoadException implements Exception {
  const BooksLoadException(this.message);

  final String message;

  @override
  String toString() => message;
}

class BookDetailsException implements Exception {
  const BookDetailsException(this.message);

  final String message;

  @override
  String toString() => message;
}

class BookSearchException implements Exception {
  const BookSearchException(this.message);

  final String message;

  @override
  String toString() => message;
}
