import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_archive/features/books/data/datasources/book_local_datasource.dart';
import 'package:online_archive/features/books/data/repositories/book_repository_impl.dart';
import 'package:online_archive/features/books/domain/repositories/book_repository.dart';

final bookLocalDataSourceProvider = Provider<BookLocalDataSource>((ref) {
  return BookLocalDataSourceImpl();
});

final bookRepositoryProvider = Provider<BookRepository>((ref) {
  return BookRepositoryImpl(ref.watch(bookLocalDataSourceProvider));
});
