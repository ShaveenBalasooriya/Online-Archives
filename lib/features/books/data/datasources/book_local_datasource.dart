import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:online_archive/core/error/exceptions.dart';
import 'package:online_archive/features/books/data/models/book_model.dart';

abstract interface class BookLocalDataSource {
  Future<List<BookModel>> getBooks();

  /// Throws [NotFoundException] if no book has [id].
  Future<BookModel> getBookById(String id);
}

/// Reads from the bundled `assets/data/books.json` asset once, then serves
/// and mutates an in-memory copy — assets can't be written back to at
/// runtime, so this is what stands in for persistence until a real
/// `/api/books` implementation is swapped in.
class BookLocalDataSourceImpl implements BookLocalDataSource {
  BookLocalDataSourceImpl({this.assetPath = 'assets/data/books.json'});

  final String assetPath;
  List<BookModel>? _cache;

  Future<List<BookModel>> _loadCache() async {
    final cache = _cache;
    if (cache != null) return cache;

    final raw = await rootBundle.loadString(assetPath);
    final decoded = jsonDecode(raw) as List<dynamic>;
    final books = decoded
        .map((json) => BookModel.fromJson(json as Map<String, dynamic>))
        .toList();
    _cache = books;
    return books;
  }

  @override
  Future<List<BookModel>> getBooks() async {
    return List.unmodifiable(await _loadCache());
  }

  @override
  Future<BookModel> getBookById(String id) async {
    final books = await _loadCache();
    for (final book in books) {
      if (book.id == id) return book;
    }
    throw NotFoundException("Book with ID '$id' was not found.");
  }
}
