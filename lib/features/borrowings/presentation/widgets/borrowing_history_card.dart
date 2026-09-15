import 'package:flutter/material.dart';
import 'package:online_archive/features/books/domain/entities/book.dart';
import 'package:online_archive/features/books/presentation/pages/book_details_page.dart';
import 'package:online_archive/features/borrowings/domain/entities/borrowing.dart';
import 'package:online_archive/features/borrowings/presentation/widgets/borrowing_card.dart';

class BorrowingHistoryCard extends StatelessWidget {
  const BorrowingHistoryCard({
    required this.book,
    required this.borrowing,
    super.key,
  });

  final Book book;
  final Borrowing borrowing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card.filled(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BookCoverThumbnail(url: book.coverImageUrl),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(book.title, style: theme.textTheme.titleMedium),
                    Text(
                      book.author,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${book.publishedYear}',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: FilledButton(
                        onPressed: () => BookDetailsPage.open(context, book.id),
                        child: const Text('View'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
