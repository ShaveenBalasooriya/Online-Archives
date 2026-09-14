import 'package:online_archive/features/books/presentation/providers/book_providers.dart';
import 'package:online_archive/features/borrowings/data/repositories/borrowing_repository_impl.dart';
import 'package:online_archive/features/borrowings/domain/repositories/borrowing_repository.dart';
import 'package:online_archive/features/borrowings/domain/usecases/create_borrowing_usecase.dart';
import 'package:online_archive/features/borrowings/domain/usecases/get_borrowings_by_member_usecase.dart';
import 'package:online_archive/features/borrowings/domain/usecases/mark_overdue_usecase.dart';
import 'package:online_archive/features/borrowings/domain/usecases/return_borrowing_usecase.dart';
import 'package:online_archive/features/members/presentation/providers/member_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/borrowing_local_datasource.dart';

part 'borrowing_providers.g.dart';

@Riverpod(keepAlive: true)
BorrowingLocalDataSource borrowingLocalDataSource(Ref ref) {
  return BorrowingLocalDataSourceImpl();
}

@riverpod
BorrowingRepository borrowingRepository(Ref ref) {
  return BorrowingRepositoryImpl(
    ref.watch(borrowingLocalDataSourceProvider),
    ref.watch(memberLocalDataSourceProvider),
    ref.watch(bookLocalDataSourceProvider),
  );
}

@riverpod
CreateBorrowingUsecase createBorrowing(Ref ref) {
  return CreateBorrowingUsecase(ref.watch(borrowingRepositoryProvider));
}

@riverpod
GetBorrowingsByMemberUsecase getBorrowingsByMember(Ref ref) {
  return GetBorrowingsByMemberUsecase(ref.watch(borrowingRepositoryProvider));
}

@riverpod
ReturnBorrowingUsecase returnBorrowing(Ref ref) {
  return ReturnBorrowingUsecase(ref.watch(borrowingRepositoryProvider));
}

@riverpod
MarkOverdueUsecase markOverdue(Ref ref) {
  return MarkOverdueUsecase(ref.watch(borrowingRepositoryProvider));
}
