import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_archive/features/books/domain/entities/book.dart';
import 'package:online_archive/features/books/presentation/pages/book_details_page.dart';
import 'package:online_archive/features/books/presentation/pages/book_search_details_page.dart';
import 'package:online_archive/features/books/presentation/providers/book_providers.dart';
import 'package:online_archive/features/books/presentation/widgets/book_card.dart';
import 'package:online_archive/features/books/presentation/widgets/book_search_bar.dart';

const _railHeight = 300.0;
const _railCardWidth = 160.0;
const _horizontalPadding = 16.0;

class BookSearchPage extends ConsumerWidget {
  const BookSearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksAsync = ref.watch(booksListProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const _PageHeader(),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                _horizontalPadding,
                0,
                _horizontalPadding,
                8,
              ),
              child: BookSearchBar(
                onSubmitted: (query) =>
                    BookSearchDetailsPage.open(context, query),
              ),
            ),
            Expanded(
              child: booksAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) =>
                    Center(child: Text('Failed to load books: $error')),
                data: (books) => _BookSearchContent(books: books),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        _horizontalPadding,
        24,
        _horizontalPadding,
        16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ONLINE ARCHIVE',
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.primary,
              letterSpacing: 1.6,
            ),
          ),
          const SizedBox(height: 6),
          Text('Discover', style: theme.textTheme.displaySmall),
          const SizedBox(height: 6),
          Text(
            'Browse and borrow from the collection',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _BookSearchContent extends StatelessWidget {
  const _BookSearchContent({required this.books});

  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) {
      return const Center(child: Text('No books found.'));
    }

    // Placeholder groupings: the backend has no featured/recommended
    // endpoints, so these are slices of the same list for now.
    final featured = books.take(5).toList();
    final recommended = books.reversed.take(5).toList();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _BookRail(title: 'Featured', books: featured),
        ),
        SliverToBoxAdapter(
          child: _BookRail(title: 'You might like', books: recommended),
        ),
        const SliverToBoxAdapter(child: _SectionHeader('All books')),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            _horizontalPadding,
            0,
            _horizontalPadding,
            24,
          ),
          sliver: SliverGrid.builder(
            gridDelegate: bookCardGridDelegate,
            itemCount: books.length,
            itemBuilder: (context, index) => BookCard(
              book: books[index],
              onTap: () => BookDetailsPage.open(context, books[index].id),
            ),
          ),
        ),
      ],
    );
  }
}

class _BookRail extends StatelessWidget {
  const _BookRail({required this.title, required this.books});

  final String title;
  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(title),
        SizedBox(
          height: _railHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
            itemCount: books.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) => SizedBox(
              width: _railCardWidth,
              child: BookCard(
                book: books[index],
                onTap: () => BookDetailsPage.open(context, books[index].id),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        _horizontalPadding,
        24,
        _horizontalPadding,
        12,
      ),
      child: Text(title, style: Theme.of(context).textTheme.headlineSmall),
    );
  }
}
