import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_archive/features/borrowings/presentation/providers/borrowing_providers.dart';
import 'package:online_archive/features/borrowings/presentation/widgets/borrowing_history_card.dart';
import 'package:online_archive/features/members/presentation/providers/member_providers.dart';

class BorrowingHistoryPage extends ConsumerWidget {
  const BorrowingHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberId = ref.watch(currentMemberIdProvider);
    final borrowingsAsync = ref.watch(
      memberBorrowingsWithBooksProvider(memberId),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Borrow History')),
      body: SafeArea(
        child: borrowingsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) =>
              Center(child: Text('Failed to load borrowings: $error')),
          data: (borrowings) => SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                for (final item in borrowings) ...[
                  BorrowingHistoryCard(
                    book: item.book,
                    borrowing: item.borrowing,
                  ),
                  const SizedBox(height: 16),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
