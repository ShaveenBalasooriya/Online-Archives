import 'package:equatable/equatable.dart';

/// Client-side representation of a backend error.
/// detail, and [statusCode] is the HTTP status so callers can branch UI
/// behavior without re-deriving it from [code].
class Failure extends Equatable {
  const Failure({
    required this.code,
    required this.message,
    required this.statusCode,
  });

  final String code;
  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [code, message, statusCode];
}
