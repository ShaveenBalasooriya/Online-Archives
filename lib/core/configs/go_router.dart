import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:online_archive/core/presentation/widgets/scaffold_with_nav_bar.dart';
import 'package:online_archive/features/books/presentation/pages/book_details_page.dart';
import 'package:online_archive/features/books/presentation/pages/book_search_details_page.dart';
import 'package:online_archive/features/borrowings/presentation/pages/borrowing_history_page.dart';
import 'package:online_archive/features/members/presentation/pages/home.dart';

import '../../features/books/presentation/pages/book_search_page.dart';

final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellHome',
);
final _shellNavigatorSearchKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellSearch',
);
final _shellNavigatorHistoryKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellHistory',
);

final appRouter = GoRouter(
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          ScaffoldWithNavBar(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            GoRoute(path: '/', builder: (context, state) => const Home()),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorSearchKey,
          routes: [
            GoRoute(
              path: '/book',
              builder: (context, state) => const BookSearchPage(),
              routes: [
                GoRoute(
                  path: 'details/:bookId',
                  builder: (context, state) =>
                      BookDetailsPage(bookId: state.pathParameters['bookId']!),
                ),
                GoRoute(
                  path: 'search',
                  builder: (context, state) => BookSearchDetailsPage(
                    query: state.uri.queryParameters['q'] ?? '',
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHistoryKey,
          routes: [
            GoRoute(
              path: '/history',
              builder: (context, state) => const BorrowingHistoryPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
