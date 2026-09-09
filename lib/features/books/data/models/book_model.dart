import 'package:online_archive/features/books/domain/entities/book.dart';

class BookModel extends Book {
  const BookModel({
    required super.id,
    required super.title,
    required super.author,
    required super.isbn,
    required super.publishedYear,
    required super.totalCopies,
    required super.availableCopies,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      isbn: json['isbn'] as String,
      publishedYear: json['publishedYear'] as int,
      totalCopies: json['totalCopies'] as int,
      availableCopies: json['availableCopies'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'isbn': isbn,
      'publishedYear': publishedYear,
      'totalCopies': totalCopies,
      'availableCopies': availableCopies,
    };
  }
}
