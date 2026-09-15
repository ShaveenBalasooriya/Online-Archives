import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:online_archive/core/error/exceptions.dart';
import 'package:online_archive/features/borrowings/data/models/borrowing_model.dart';
import 'package:online_archive/features/borrowings/domain/entities/enums/borrowing_status.dart';

abstract interface class BorrowingLocalDataSource {
  Future<void> createBorrowing(BorrowingModel borrowing);

  Future<List<BorrowingModel>> getBorrowingsByMember(String memberId);

  Future<BorrowingModel> getBorrowingById(String id);

  Future<void> updateBorrowing(BorrowingModel borrowing);

  Future<int> markOverdue();
}

/// Seeds an in-memory store from the bundled `assets/data/borrowings.json`
/// asset, then reads and writes that store — this stands in for a real
/// `/api/borrowings` implementation until one is swapped in.
class BorrowingLocalDataSourceImpl implements BorrowingLocalDataSource {
  BorrowingLocalDataSourceImpl({
    this.assetPath = 'assets/data/borrowings.json',
  });

  final String assetPath;

  /// The in-memory "database" backing this mock. Null until [_ensureStore]
  /// seeds it from [assetPath]; from then on all reads and writes go
  /// through this list directly, so mutations persist for the lifetime of
  /// this instance.
  List<BorrowingModel>? _store;

  Future<List<BorrowingModel>> _ensureStore() async {
    final store = _store;
    if (store != null) return store;

    final raw = await rootBundle.loadString(assetPath);
    final decoded = jsonDecode(raw) as List<dynamic>;
    final borrowings = decoded
        .map((json) => BorrowingModel.fromJson(json as Map<String, dynamic>))
        .toList();
    _store = borrowings;
    return borrowings;
  }

  @override
  Future<void> createBorrowing(BorrowingModel borrowing) async {
    final borrowings = await _ensureStore();
    borrowings.add(borrowing);
  }

  @override
  Future<List<BorrowingModel>> getBorrowingsByMember(String memberId) async {
    final borrowings = await _ensureStore();
    return borrowings
        .where((borrowing) => borrowing.memberId == memberId)
        .toList();
  }

  @override
  Future<BorrowingModel> getBorrowingById(String id) async {
    final borrowings = await _ensureStore();
    for (final borrowing in borrowings) {
      if (borrowing.id == id) return borrowing;
    }
    throw NotFoundException("Borrowing with ID '$id' was not found.");
  }

  @override
  Future<void> updateBorrowing(BorrowingModel borrowing) async {
    final borrowings = await _ensureStore();
    final index = borrowings.indexWhere(
      (existing) => existing.id == borrowing.id,
    );
    if (index == -1) {
      throw NotFoundException(
        "Borrowing with ID '${borrowing.id}' was not found.",
      );
    }
    borrowings[index] = borrowing;
  }

  @override
  Future<int> markOverdue() async {
    final borrowings = await _ensureStore();
    final now = DateTime.now();
    var count = 0;
    for (var i = 0; i < borrowings.length; i++) {
      final borrowing = borrowings[i];
      if (borrowing.status == BorrowingStatus.borrowed &&
          borrowing.dueDate.isBefore(now)) {
        borrowings[i] = BorrowingModel(
          id: borrowing.id,
          bookId: borrowing.bookId,
          memberId: borrowing.memberId,
          borrowedDate: borrowing.borrowedDate,
          dueDate: borrowing.dueDate,
          returnedDate: borrowing.returnedDate,
          status: BorrowingStatus.overdue,
        );
        count++;
      }
    }
    return count;
  }
}
