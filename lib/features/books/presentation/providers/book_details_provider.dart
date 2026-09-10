import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_archive/features/books/domain/entities/book.dart';
import 'package:online_archive/features/books/presentation/providers/get_book_by_id_provider.dart';

/// Fetches a single book by id, so the details page only needs to be handed
/// an id rather than a whole [Book].
final bookDetailsProvider = FutureProvider.family<Book, String>((
  ref,
  bookId,
) async {
  await Future<void>.delayed(const Duration(seconds: 1));

  final getBookById = ref.watch(getBookByIdUseCaseProvider);
  final result = await getBookById(bookId);

  return result.match(
    (failure) => throw BookDetailsException(failure.message),
    (book) => book,
  );
});

class BookDetailsException implements Exception {
  const BookDetailsException(this.message);

  final String message;

  @override
  String toString() => message;
}
