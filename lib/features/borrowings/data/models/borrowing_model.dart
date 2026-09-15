import 'package:online_archive/features/borrowings/domain/entities/borrowing.dart';
import 'package:online_archive/features/borrowings/domain/entities/enums/borrowing_status.dart';

class BorrowingModel extends Borrowing {
  const BorrowingModel({
    required super.id,
    required super.bookId,
    required super.memberId,
    required super.borrowedDate,
    required super.dueDate,
    required super.returnedDate,
    required super.status,
  });

  factory BorrowingModel.fromJson(Map<String, dynamic> json) {
    return BorrowingModel(
      id: json['id'] as String,
      bookId: json['bookId'] as String,
      memberId: json['memberId'] as String,
      borrowedDate: DateTime.parse(json['borrowedDate'] as String),
      dueDate: DateTime.parse(json['dueDate'] as String),
      returnedDate: json['returnedDate'] == null
          ? null
          : DateTime.parse(json['returnedDate'] as String),
      status: BorrowingStatus.fromValue(json['status'] as int),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookId': bookId,
      'memberId': memberId,
      'borrowedDate': borrowedDate.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
      'returnedDate': returnedDate?.toIso8601String(),
      'status': status.value,
    };
  }
}
