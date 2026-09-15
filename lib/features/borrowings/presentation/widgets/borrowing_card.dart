import 'package:flutter/material.dart';
import 'package:online_archive/features/books/domain/entities/book.dart';
import 'package:online_archive/features/borrowings/domain/entities/borrowing.dart';

class BorrowingCard extends StatelessWidget {
  const BorrowingCard({
    required this.book,
    required this.borrowing,
    this.onReturn,
    super.key,
  });

  final Book book;
  final Borrowing borrowing;
  final VoidCallback? onReturn;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final daysRemaining = borrowing.dueDate.difference(DateTime.now()).inDays;
    final isOverdue = daysRemaining < 0;
    final dueText = isOverdue ? 'Overdue' : 'Due in $daysRemaining days';

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
                    const SizedBox(height: 8),
                    Text(
                      dueText,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: isOverdue
                            ? theme.colorScheme.error
                            : theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: FilledButton(
                        onPressed: onReturn,
                        child: const Text('Return'),
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

class BookCoverThumbnail extends StatelessWidget {
  const BookCoverThumbnail({required this.url, super.key});

  final String? url;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final placeholder = ColoredBox(
      color: colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.menu_book_outlined,
        color: colorScheme.onSurfaceVariant,
        size: 28,
      ),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: 104,
        child: url == null
            ? placeholder
            : Image.network(
                url!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => placeholder,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return ColoredBox(
                    color: colorScheme.surfaceContainerHighest,
                    child: const Center(
                      child: SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
