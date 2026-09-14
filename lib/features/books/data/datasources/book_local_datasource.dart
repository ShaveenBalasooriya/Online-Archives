import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:online_archive/core/error/exceptions.dart';
import 'package:online_archive/features/books/data/models/book_model.dart';

abstract interface class BookLocalDataSource {
  Future<List<BookModel>> getBooks();

  /// Throws [NotFoundException] if no book has [id].
  Future<BookModel> getBookById(String id);

  /// Adjusts a book's `availableCopies` by [delta] (negative when a
  /// borrowing is created, positive when one is returned). Throws
  /// [NotFoundException] if no book has [id].
  Future<void> adjustAvailableCopies(String id, int delta);
}

/// Seeds an in-memory store from the bundled `assets/data/books.json`
/// asset, then reads and writes that store — this stands in for a real
/// `/api/books` implementation until one is swapped in.
class BookLocalDataSourceImpl implements BookLocalDataSource {
  BookLocalDataSourceImpl({this.assetPath = 'assets/data/books.json'});

  final String assetPath;

  /// The in-memory "database" backing this mock. Null until [_ensureStore]
  /// seeds it from [assetPath]; from then on all reads and writes go
  /// through this list directly, so mutations (see [adjustAvailableCopies])
  /// persist for the lifetime of this instance.
  List<BookModel>? _store;

  Future<List<BookModel>> _ensureStore() async {
    final store = _store;
    if (store != null) return store;

    final raw = await rootBundle.loadString(assetPath);
    final decoded = jsonDecode(raw) as List<dynamic>;
    final books = decoded
        .map((json) => BookModel.fromJson(json as Map<String, dynamic>))
        .toList();
    _store = books;
    return books;
  }

  @override
  Future<List<BookModel>> getBooks() async {
    return List.unmodifiable(await _ensureStore());
  }

  @override
  Future<BookModel> getBookById(String id) async {
    final books = await _ensureStore();
    for (final book in books) {
      if (book.id == id) return book;
    }
    throw NotFoundException("Book with ID '$id' was not found.");
  }

  @override
  Future<void> adjustAvailableCopies(String id, int delta) async {
    final books = await _ensureStore();
    final index = books.indexWhere((book) => book.id == id);
    if (index == -1) {
      throw NotFoundException("Book with ID '$id' was not found.");
    }
    final book = books[index];
    books[index] = BookModel(
      id: book.id,
      title: book.title,
      author: book.author,
      isbn: book.isbn,
      publishedYear: book.publishedYear,
      totalCopies: book.totalCopies,
      availableCopies: book.availableCopies + delta,
      coverImageUrl: book.coverImageUrl,
      description: book.description,
    );
  }
}
