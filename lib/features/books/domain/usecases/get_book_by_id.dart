import 'package:fpdart/fpdart.dart';
import 'package:online_archive/core/error/failure.dart';
import 'package:online_archive/core/usecases/usecase.dart';
import 'package:online_archive/features/books/domain/entities/book.dart';
import 'package:online_archive/features/books/domain/repositories/book_repository.dart';

/// Fetches a single book by id. Mirrors `GET /api/books/{id}`.
class GetBookById implements UseCase<Book, String> {
  const GetBookById(this._repository);

  final BookRepository _repository;

  @override
  Future<Either<Failure, Book>> call(String id) {
    return _repository.getBookById(id);
  }
}
