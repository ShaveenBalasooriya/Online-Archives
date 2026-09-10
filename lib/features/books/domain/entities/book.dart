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
    required this.coverImageUrl,
    required this.description,
  });

  final String title;
  final String author;
  final String isbn;
  final int publishedYear;
  final int totalCopies;
  final int availableCopies;

  /// Not part of the backend contract — the API's Book has neither an image
  /// nor a description field. Nullable so a real API response (which won't
  /// carry them) still maps.
  final String? coverImageUrl;
  final String? description;
}
