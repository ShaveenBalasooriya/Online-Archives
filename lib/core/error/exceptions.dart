/// Thrown by a data source when a record with the given id doesn't exist.
/// Repositories catch this and translate it into a `*.NotFound` [Failure].
class NotFoundException implements Exception {
  const NotFoundException(this.message);

  final String message;
}
