import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:online_archive/core/error/failure.dart';
import 'package:online_archive/core/usecases/usecase.dart';
import 'package:online_archive/features/books/domain/repositories/book_repository.dart';

class UpdateBook implements UseCase<Unit, UpdateBookParams> {
  const UpdateBook(this._repository);

  final BookRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(UpdateBookParams params) {
    return _repository.updateBook(
      id: params.id,
      title: params.title,
      author: params.author,
      isbn: params.isbn,
      publishedYear: params.publishedYear,
      totalCopies: params.totalCopies,
    );
  }
}

class UpdateBookParams extends Equatable {
  const UpdateBookParams({
    required this.id,
    required this.title,
    required this.author,
    required this.isbn,
    required this.publishedYear,
    required this.totalCopies,
  });

  final String id;
  final String title;
  final String author;
  final String isbn;
  final int publishedYear;
  final int totalCopies;

  @override
  List<Object?> get props => [
    id,
    title,
    author,
    isbn,
    publishedYear,
    totalCopies,
  ];
}
