import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:online_archive/core/constants/app_assets.dart';
import 'package:online_archive/features/books/domain/entities/book.dart';
import 'package:online_archive/features/books/presentation/providers/book_providers.dart';
import 'package:online_archive/features/books/presentation/widgets/book_card.dart';
import 'package:online_archive/features/books/presentation/widgets/book_search_bar.dart';

class BookSearchDetailsPage extends ConsumerWidget {
  const BookSearchDetailsPage({required this.query, super.key});

  final String query;

  static void open(BuildContext context, String query) {
    context.push(_location(query));
  }

  /// Used when searching again from this page — swaps the results rather than
  /// stacking a new page per search, so back always returns to discover.
  static void replace(BuildContext context, String query) {
    context.pushReplacement(_location(query));
  }

  static String _location(String query) =>
      '/book/search?q=${Uri.encodeQueryComponent(query)}';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultsAsync = ref.watch(bookSearchResultsProvider(query));

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: BookSearchBar(
              initialQuery: query,
              onSubmitted: (newQuery) =>
                  BookSearchDetailsPage.replace(context, newQuery),
            ),
          ),
          Expanded(
            child: resultsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Search failed: $error',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              data: (books) => books.isEmpty
                  ? const _NoResults()
                  : _ResultsGrid(query: query, books: books),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultsGrid extends StatelessWidget {
  const _ResultsGrid({required this.query, required this.books});

  final String query;
  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Text(
            '${books.length} ${books.length == 1 ? 'result' : 'results'} '
            'for "$query"',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.58,
            ),
            itemCount: books.length,
            itemBuilder: (context, index) => BookCard(
              book: books[index],
              onTap: () => context.go('/book/details/${books[index].id}'),
            ),
          ),
        ),
      ],
    );
  }
}

class _NoResults extends StatelessWidget {
  const _NoResults();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppAssets.bookNotFound,
              width: 260,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 24),
            Text(
              '404 Book Not found',
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
