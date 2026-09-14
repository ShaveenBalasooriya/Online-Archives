import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:online_archive/core/error/exceptions.dart';
import 'package:online_archive/features/books/data/models/book_model.dart';

abstract interface class BookLocalDataSource {
  Future<List<BookModel>> getBooks();

  /// Throws [NotFoundException] if no book has [id].
  Future<BookModel> getBookById(String id);
}

/// Reads from the bundled `assets/data/books.json` asset — this stands in
/// for a real `/api/books` implementation until one is swapped in.
/// Caching of results is left to Riverpod at the presentation layer.
class BookLocalDataSourceImpl implements BookLocalDataSource {
  BookLocalDataSourceImpl({this.assetPath = 'assets/data/books.json'});

  final String assetPath;

  Future<List<BookModel>> _readBooks() async {
    final raw = await rootBundle.loadString(assetPath);
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((json) => BookModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<BookModel>> getBooks() async {
    return List.unmodifiable(await _readBooks());
  }

  @override
  Future<BookModel> getBookById(String id) async {
    final books = await _readBooks();
    for (final book in books) {
      if (book.id == id) return book;
    }
    throw NotFoundException("Book with ID '$id' was not found.");
  }
}
