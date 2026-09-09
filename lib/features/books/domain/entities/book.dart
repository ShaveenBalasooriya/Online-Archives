import 'package:online_archive/core/entities/base_entity.dart';

class Book extends BaseEntity {
  const Book({
    required super.id,
    required this.title,
    required this.author,
    required this.isbn,
    required this.publishedYear,
    required this.totalCopies,
    required this.availableCopies,
  });

  final String title;
  final String author;
  final String isbn;
  final int publishedYear;
  final int totalCopies;
  final int availableCopies;
}
