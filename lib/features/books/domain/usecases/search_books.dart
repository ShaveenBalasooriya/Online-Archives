import 'package:fpdart/fpdart.dart';
import 'package:online_archive/core/error/failure.dart';
import 'package:online_archive/core/usecases/usecase.dart';
import 'package:online_archive/features/books/domain/entities/book.dart';
import 'package:online_archive/features/books/domain/repositories/book_repository.dart';

class SearchBooks implements UseCase<List<Book>, String> {
  const SearchBooks(this._repository);

  final BookRepository _repository;

  @override
  Future<Either<Failure, List<Book>>> call(String query) async {
    final result = await _repository.getAllBooks();
    return result.map((books) => _matching(books, query));
  }

  static List<Book> _matching(List<Book> books, String query) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) return const [];

    return books
        .where(
          (book) =>
              book.title.toLowerCase().contains(normalized) ||
              book.author.toLowerCase().contains(normalized),
        )
        .toList();
  }
}
