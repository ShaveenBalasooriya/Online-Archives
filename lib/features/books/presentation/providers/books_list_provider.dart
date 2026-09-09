import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_archive/core/usecases/usecase.dart';
import 'package:online_archive/features/books/domain/entities/book.dart';
import 'package:online_archive/features/books/presentation/providers/get_all_books_provider.dart';

final booksListProvider = FutureProvider<List<Book>>((ref) async {
  await Future<void>.delayed(Duration(seconds: 2));

  final getAllBooks = ref.watch(getAllBooksUseCaseProvider);
  final result = await getAllBooks(const NoParams());

  return result.match(
    (failure) => throw BooksLoadException(failure.message),
    (books) => books,
  );
});

class BooksLoadException implements Exception {
  const BooksLoadException(this.message);

  final String message;

  @override
  String toString() => message;
}
