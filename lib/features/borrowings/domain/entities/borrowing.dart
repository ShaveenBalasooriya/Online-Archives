import 'package:online_archive/core/entities/base_entity.dart';
import 'package:online_archive/features/borrowings/domain/entities/enums/borrowing_status.dart';

class Borrowing extends BaseEntity {
  const Borrowing({
    required super.id,
    required this.bookId,
    required this.memberId,
    required this.borrowedDate,
    required this.dueDate,
    required this.returnedDate,
    required this.status,
  });

  final String bookId;
  final String memberId;
  final DateTime borrowedDate;
  final DateTime dueDate;
  final DateTime? returnedDate;
  final BorrowingStatus status;
}
