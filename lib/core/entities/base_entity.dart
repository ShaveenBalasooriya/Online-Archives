import 'package:equatable/equatable.dart';

/// Base class for all domain entities.
///
/// Entities are equal when their [id]s are equal — mirrors the backend,
/// where every aggregate (Book, Member, Borrowing) is identified by a Guid.
/// Subclasses that carry additional fields relevant to equality should
/// override [props] and include `...super.props`.
abstract class BaseEntity extends Equatable {
  const BaseEntity({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];
}
