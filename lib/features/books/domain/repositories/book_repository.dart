import 'package:fpdart/fpdart.dart';
import 'package:online_archive/core/error/failure.dart';
import 'package:online_archive/features/books/domain/entities/book.dart';

/// Contract for reading and writing [Book]s.
abstract interface class BookRepository {
  /// Mirrors `POST /api/books`. Returns the new book's id.
  Future<Either<Failure, String>> createBook({
    required String title,
    required String author,
    required String isbn,
    required int publishedYear,
    required int totalCopies,
  });

  /// Mirrors `GET /api/books/{id}`.
  Future<Either<Failure, Book>> getBookById(String id);

  /// Mirrors `GET /api/books`.
  Future<Either<Failure, List<Book>>> getAllBooks();

  /// Mirrors `PUT /api/books/{id}` (full replace).
  Future<Either<Failure, Unit>> updateBook({
    required String id,
    required String title,
    required String author,
    required String isbn,
    required int publishedYear,
    required int totalCopies,
  });

  /// Mirrors `DELETE /api/books/{id}`.
  Future<Either<Failure, Unit>> deleteBook(String id);
}
