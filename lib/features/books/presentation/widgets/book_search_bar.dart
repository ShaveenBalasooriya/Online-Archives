import 'package:flutter/material.dart';

class BookSearchBar extends StatefulWidget {
  const BookSearchBar({required this.onSubmitted, this.initialQuery, super.key});

  final ValueChanged<String> onSubmitted;
  
  final String? initialQuery;

  @override
  State<BookSearchBar> createState() => _BookSearchBarState();
}

class _BookSearchBarState extends State<BookSearchBar> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initialQuery,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: _controller,
      hintText: 'Search books',
      leading: const Icon(Icons.search),
      onSubmitted: (value) {
        final trimmed = value.trim();
        if (trimmed.isEmpty) return;
        widget.onSubmitted(trimmed);
      },
    );
  }
}
