import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_archive/features/books/domain/usecases/get_all_books.dart';
import 'package:online_archive/features/books/presentation/providers/book_repository_provider.dart';

final getAllBooksUseCaseProvider = Provider<GetAllBooks>((ref) {
  return GetAllBooks(ref.watch(bookRepositoryProvider));
});
