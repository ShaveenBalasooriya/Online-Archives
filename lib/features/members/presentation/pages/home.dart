import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:online_archive/features/borrowings/presentation/providers/borrowing_providers.dart';
import 'package:online_archive/features/members/presentation/providers/member_providers.dart';

import '../widgets/borrowing_card.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberId = ref.watch(currentMemberIdProvider);
    final memberAsync = ref.watch(memberDetailsProvider(memberId));
    final borrowingsAsync = ref.watch(
      memberBorrowingsWithBooksProvider(memberId),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 40),
            Center(
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                radius: 60,
                child: Icon(Icons.person, color: Colors.white, size: 60),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: memberAsync.when(
                loading: () => const CircularProgressIndicator(),
                error: (error, stackTrace) => Text(
                  'Error loading name',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                data: (member) => Text(
                  'Welcome back ${member.fullName}',
                  style: Theme.of(context).textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Current Borrowings',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: borrowingsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) =>
                    Text('Failed to load borrowings: $error'),
                data: (borrowings) => Column(
                  children: borrowings
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: BorrowingCard(
                            book: item.book,
                            borrowing: item.borrowing,
                            onReturn: () => ScaffoldMessenger.of(context)
                                .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Returning isn\'t wired up yet.',
                                    ),
                                  ),
                                ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () => context.go('/history'),
                  child: const Text('Borrow History'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
