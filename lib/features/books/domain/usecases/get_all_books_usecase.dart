import 'package:fpdart/fpdart.dart';
import 'package:online_archive/core/error/failure.dart';
import 'package:online_archive/core/usecases/usecase.dart';
import 'package:online_archive/features/books/domain/entities/book.dart';
import 'package:online_archive/features/books/domain/repositories/book_repository.dart';

/// Fetches every book. Mirrors `GET /api/books` (no pagination).
class GetAllBooksUsecase implements UseCase<List<Book>, NoParams> {
  const GetAllBooksUsecase(this._repository);

  final BookRepository _repository;

  @override
  Future<Either<Failure, List<Book>>> call(NoParams params) {
    return _repository.getAllBooks();
  }
}
