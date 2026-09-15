/// Mirrors the backend's `status` enum on a Borrowing, which is serialized
/// as an integer (`0=Borrowed, 1=Returned, 2=Overdue`), not a string.
enum BorrowingStatus {
  borrowed(0),
  returned(1),
  overdue(2);

  const BorrowingStatus(this.value);

  final int value;

  factory BorrowingStatus.fromValue(int value) {
    return BorrowingStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () =>
          throw ArgumentError('Unknown BorrowingStatus value: $value'),
    );
  }
}
