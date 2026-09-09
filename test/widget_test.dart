import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:online_archive/features/books/presentation/widgets/book_card.dart';
import 'package:online_archive/main.dart';

void main() {
  testWidgets('Book search page shows a loading indicator, then the rails', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Past the mock network delay in booksListProvider, then one more frame
    // to rebuild with the loaded data.
    await tester.pump(const Duration(seconds: 3));
    await tester.pump();

    expect(find.text('Featured'), findsOneWidget);
    expect(find.text('You might like'), findsOneWidget);
    expect(find.byType(BookCard), findsWidgets);
  });
}
