import 'package:fpdart/fpdart.dart';
import 'package:online_archive/core/error/failure.dart';
import 'package:online_archive/features/books/domain/entities/book.dart';

/// Contract for reading and writing [Book]s.
abstract interface class BookRepository {

  Future<Either<Failure, Book>> getBookById(String id);

  Future<Either<Failure, List<Book>>> getAllBooks();
}
