import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_archive/features/books/domain/entities/book.dart';
import 'package:online_archive/features/books/presentation/providers/book_details_provider.dart';

const _horizontalPadding = 16.0;
const _coverWidth = 200.0;

class BookDetailsPage extends ConsumerWidget {
  const BookDetailsPage({required this.bookId, super.key});

  final String bookId;

  static void open(BuildContext context, String bookId) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => BookDetailsPage(bookId: bookId)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookAsync = ref.watch(bookDetailsProvider(bookId));

    return Scaffold(
      appBar: AppBar(),
      body: bookAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(_horizontalPadding),
            child: Text(
              'Failed to load this book: $error',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        data: (book) => _BookDetails(book: book),
      ),
    );
  }
}

class _BookDetails extends StatelessWidget {
  const _BookDetails({required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final description = book.description;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              _horizontalPadding,
              0,
              _horizontalPadding,
              24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: _BookCover(url: book.coverImageUrl)),
                const SizedBox(height: 24),
                Text(book.title, style: theme.textTheme.headlineMedium),
                const SizedBox(height: 4),
                Text(
                  book.author,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                _AvailabilityChip(book: book),
                const SizedBox(height: 24),
                _MetaRow(label: 'Published', value: '${book.publishedYear}'),
                _MetaRow(label: 'ISBN', value: book.isbn),
                _MetaRow(
                  label: 'Copies',
                  value: '${book.availableCopies} of ${book.totalCopies}',
                ),
                if (description != null) ...[
                  const SizedBox(height: 24),
                  Text('About this book', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        _BorrowBar(book: book),
      ],
    );
  }
}

class _BorrowBar extends StatelessWidget {
  const _BorrowBar({required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isAvailable = book.availableCopies > 0;

    return Material(
      color: theme.colorScheme.surface,
      elevation: 3,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(_horizontalPadding),
          child: FilledButton(
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
              textStyle: theme.textTheme.titleMedium,
            ),
            onPressed: isAvailable
                ? () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Borrowing isn\'t wired up yet.'),
                    ),
                  )
                : null,
            child: const Text('Borrow'),
          ),
        ),
      ),
    );
  }
}

class _AvailabilityChip extends StatelessWidget {
  const _AvailabilityChip({required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    final isAvailable = book.availableCopies > 0;

    return Chip(
      avatar: Icon(
        isAvailable ? Icons.check_circle_outline : Icons.remove_circle_outline,
        size: 18,
      ),
      label: Text(
        isAvailable
            ? '${book.availableCopies} available'
            : 'All copies borrowed',
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 96,
            child: Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(child: Text(value, style: theme.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}

class _BookCover extends StatelessWidget {
  const _BookCover({required this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final placeholder = ColoredBox(
      color: colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.menu_book_outlined,
        color: colorScheme.onSurfaceVariant,
        size: 56,
      ),
    );
    final url = this.url;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: _coverWidth,
        child: AspectRatio(
          aspectRatio: 3 / 4,
          child: url == null
              ? placeholder
              : Image.network(
                  url,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => placeholder,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return ColoredBox(
                      color: colorScheme.surfaceContainerHighest,
                      child: const Center(
                        child: SizedBox.square(
                          dimension: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
