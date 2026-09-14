import 'package:fpdart/fpdart.dart';
import 'package:online_archive/core/error/exceptions.dart';
import 'package:online_archive/core/error/failure.dart';
import 'package:online_archive/features/books/data/datasources/book_local_datasource.dart';
import 'package:online_archive/features/books/domain/entities/book.dart';
import 'package:online_archive/features/books/domain/repositories/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  const BookRepositoryImpl(this._localDataSource);

  final BookLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, Book>> getBookById(String id) async {
    try {
      final book = await _localDataSource.getBookById(id);
      return Right(book);
    } on NotFoundException catch (error) {
      return Left(_notFoundFailure(error));
    } catch (error) {
      return Left(_unexpectedFailure(error));
    }
  }

  @override
  Future<Either<Failure, List<Book>>> getAllBooks() async {
    try {
      final books = await _localDataSource.getBooks();
      return Right(books);
    } catch (error) {
      return Left(_unexpectedFailure(error));
    }
  }

  Failure _notFoundFailure(NotFoundException error) {
    return Failure(
      code: 'Book.NotFound',
      message: error.message,
      statusCode: 404,
    );
  }

  Failure _unexpectedFailure(Object error) {
    return Failure(
      code: 'Unexpected',
      message: error.toString(),
      statusCode: 500,
    );
  }
}
