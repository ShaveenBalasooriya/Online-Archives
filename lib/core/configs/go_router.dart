import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:online_archive/features/books/presentation/pages/book_details_page.dart';
import 'package:online_archive/features/books/presentation/pages/book_search_details_page.dart';

import '../../features/books/presentation/pages/book_search_page.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const BookSearchPage(),
    ),
    GoRoute(
      path: '/book/details/:bookId',
      builder: (BuildContext context, GoRouterState state) =>
          BookDetailsPage(bookId: state.pathParameters['bookId']!),
    ),
    GoRoute(
      path: '/book/search',
      builder: (BuildContext context, GoRouterState state) =>
          BookSearchDetailsPage(
            query: state.uri.queryParameters['q'] ?? '',
          ),
    ),
  ],
);
