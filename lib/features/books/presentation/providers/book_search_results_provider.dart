import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_archive/features/books/domain/entities/book.dart';
import 'package:online_archive/features/books/domain/usecases/search_books.dart';
import 'package:online_archive/features/books/presentation/providers/book_repository_provider.dart';

final searchBooksUseCaseProvider = Provider<SearchBooks>((ref) {
  return SearchBooks(ref.watch(bookRepositoryProvider));
});

/// Results for one search query. An empty list means nothing matched.
final bookSearchResultsProvider = FutureProvider.family<List<Book>, String>((
  ref,
  query,
) async {
  await Future<void>.delayed(const Duration(milliseconds: 500));

  final searchBooks = ref.watch(searchBooksUseCaseProvider);
  final result = await searchBooks(query);

  return result.match(
    (failure) => throw BookSearchException(failure.message),
    (books) => books,
  );
});

class BookSearchException implements Exception {
  const BookSearchException(this.message);

  final String message;

  @override
  String toString() => message;
}
