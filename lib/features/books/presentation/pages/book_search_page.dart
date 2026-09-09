import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_archive/features/books/domain/entities/book.dart';
import 'package:online_archive/features/books/presentation/providers/books_list_provider.dart';
import 'package:online_archive/features/books/presentation/widgets/book_card.dart';

const _railHeight = 300.0;
const _railCardWidth = 160.0;
const _horizontalPadding = 16.0;

class BookSearchPage extends ConsumerWidget {
  const BookSearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksAsync = ref.watch(booksListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Books')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(
              _horizontalPadding,
              8,
              _horizontalPadding,
              0,
            ),
            child: SearchBar(
              hintText: 'Search books',
              leading: Icon(Icons.search),
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
          padding: const EdgeInsets.fromLTRB(_horizontalPadding, 0, _horizontalPadding, 24),
          sliver: SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.58,
            ),
            itemCount: books.length,
            itemBuilder: (context, index) => BookCard(book: books[index]),
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
              child: BookCard(book: books[index]),
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
      padding: const EdgeInsets.fromLTRB(_horizontalPadding, 24, _horizontalPadding, 12),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}
