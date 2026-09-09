import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:online_archive/core/error/failure.dart';
import 'package:online_archive/core/usecases/usecase.dart';
import 'package:online_archive/features/books/domain/repositories/book_repository.dart';

/// Creates a book. Mirrors `POST /api/books`; returns the new book's id.
class CreateBook implements UseCase<String, CreateBookParams> {
  const CreateBook(this._repository);

  final BookRepository _repository;

  @override
  Future<Either<Failure, String>> call(CreateBookParams params) {
    return _repository.createBook(
      title: params.title,
      author: params.author,
      isbn: params.isbn,
      publishedYear: params.publishedYear,
      totalCopies: params.totalCopies,
    );
  }
}

class CreateBookParams extends Equatable {
  const CreateBookParams({
    required this.title,
    required this.author,
    required this.isbn,
    required this.publishedYear,
    required this.totalCopies,
  });

  final String title;
  final String author;
  final String isbn;
  final int publishedYear;
  final int totalCopies;

  @override
  List<Object?> get props => [
    title,
    author,
    isbn,
    publishedYear,
    totalCopies,
  ];
}
