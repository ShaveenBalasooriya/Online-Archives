import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_archive/core/theme/app_theme.dart';
import 'package:online_archive/features/books/presentation/pages/book_search_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Archive',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      highContrastTheme: AppTheme.lightHighContrast,
      highContrastDarkTheme: AppTheme.darkHighContrast,
      themeMode: ThemeMode.light,
      home: const BookSearchPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
