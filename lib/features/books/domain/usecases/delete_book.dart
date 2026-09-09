import 'package:fpdart/fpdart.dart';
import 'package:online_archive/core/error/failure.dart';
import 'package:online_archive/core/usecases/usecase.dart';
import 'package:online_archive/features/books/domain/repositories/book_repository.dart';

/// Deletes a book. Mirrors `DELETE /api/books/{id}` (204).
class DeleteBook implements UseCase<Unit, String> {
  const DeleteBook(this._repository);

  final BookRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(String id) {
    return _repository.deleteBook(id);
  }
}
