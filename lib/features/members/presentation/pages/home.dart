import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:online_archive/core/constants/app_assets.dart';
import 'package:online_archive/features/borrowings/domain/entities/enums/borrowing_status.dart';
import 'package:online_archive/features/borrowings/presentation/providers/borrowing_providers.dart';
import 'package:online_archive/features/borrowings/presentation/widgets/borrowing_card.dart';
import 'package:online_archive/features/members/presentation/providers/member_providers.dart';

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
            Container(
              child: borrowingsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Failed to load borrowings: $error'),
                ),
                data: (borrowings) {
                  final activeBorrowings = borrowings
                      .where(
                        (item) =>
                            item.borrowing.status != BorrowingStatus.returned,
                      )
                      .toList();

                  if (activeBorrowings.isEmpty) {
                    return Column(
                      children: [
                        Center(child: Image.asset(AppAssets.empty, width: 260)),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Start browsing and borrowing',
                            style: Theme.of(context).textTheme.headlineLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                          child: SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primary,
                              ),
                              onPressed: () => context.go('/book'),
                              child: const Text('Go to search'),
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  return Column(
                    children: [
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: activeBorrowings
                              .map(
                                (item) => Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: BorrowingCard(
                                    book: item.book,
                                    borrowing: item.borrowing,
                                    onReturn: () => _returnBorrowing(
                                      context,
                                      ref,
                                      memberId,
                                      item.borrowing.id,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                        child: SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primary,
                            ),
                            onPressed: () => context.go('/history'),
                            child: const Text('Borrow History'),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _returnBorrowing(
  BuildContext context,
  WidgetRef ref,
  String memberId,
  String borrowingId,
) async {
  final returnBorrowing = ref.read(returnBorrowingProvider);
  final result = await returnBorrowing(borrowingId);

  if (!context.mounted) return;

  result.match(
    (failure) =>
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(failure.message))),
    (_) {
      ref.invalidate(borrowingsByMemberProvider(memberId));
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Book returned.')));
    },
  );
}
