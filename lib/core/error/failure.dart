/// Abstract class for handling failures in EasyGo.
abstract class EasyGoFailure {
  /// Error message describing the failure.
  final String message;

  /// Optional status code for failures (e.g., HTTP status codes).
  final int? statusCode;

  const EasyGoFailure({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() =>
      'EasyGoFailure(message: $message, statusCode: $statusCode)';
}

/// Failure related to local database operations.
class LocalDatabaseFailure extends EasyGoFailure {
  const LocalDatabaseFailure({
    required String message,
  }) : super(message: message);
}

/// Failure related to API calls.
class ApiFailure extends EasyGoFailure {
  const ApiFailure({
    required int statusCode,
    required String message,
  }) : super(message: message, statusCode: statusCode);
}
