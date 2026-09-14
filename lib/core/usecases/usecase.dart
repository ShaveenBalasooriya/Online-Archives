import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:online_archive/core/error/failure.dart';

/// Contract every domain use case implements.
///
/// [SuccessType] is the success value, [Params] is whatever the use case
/// needs to run — a dedicated params class, a single primitive (e.g.
/// `String` for an id), or [NoParams] when nothing is needed.
abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

/// Marker params for use cases that take no input.
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
