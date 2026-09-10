import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_archive/features/books/domain/usecases/get_book_by_id.dart';
import 'package:online_archive/features/books/presentation/providers/book_repository_provider.dart';

final getBookByIdUseCaseProvider = Provider<GetBookById>((ref) {
  return GetBookById(ref.watch(bookRepositoryProvider));
});
