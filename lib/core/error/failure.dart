import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

/// **🔹 Base Failure Class (Abstract)**
abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

/// **🔹 Local Database Failure**
class LocalDatabaseFailure extends Failure {
  const LocalDatabaseFailure({required String message})
      : super(message: message);
}

/// **🔹 API Failure (Handles Dio Errors)**
class ApiFailure extends Failure {
  final int? statusCode;

  const ApiFailure({required String message, this.statusCode})
      : super(message: message, statusCode: statusCode);

  /// **🛠 Convert Dio Errors into Readable Failures**
  factory ApiFailure.fromDioError(DioException error) {
    String message = "An unexpected error occurred.";

    if (error.response != null) {
      switch (error.response?.statusCode) {
        case 400:
          message = "Bad request. Please check your input.";
          break;
        case 401:
          message = "Unauthorized. Please check your credentials.";
          break;
        case 403:
          message = "Forbidden. You don't have permission.";
          break;
        case 404:
          message = "Resource not found.";
          break;
        case 500:
          message = "Internal server error. Please try again later.";
          break;
        default:
          message = error.response?.data["message"] ?? "API error occurred.";
      }
    } else if (error.type == DioExceptionType.connectionTimeout) {
      message = "Connection timeout. Please check your internet.";
    } else if (error.type == DioExceptionType.sendTimeout) {
      message = "Request timed out. Please try again.";
    } else if (error.type == DioExceptionType.receiveTimeout) {
      message = "Server took too long to respond.";
    } else if (error.type == DioExceptionType.badResponse) {
      message = "Invalid server response.";
    } else if (error.type == DioExceptionType.cancel) {
      message = "Request was cancelled.";
    } else if (error.type == DioExceptionType.unknown) {
      message = "Network error. Please check your connection.";
    }

    return ApiFailure(
      statusCode: error.response?.statusCode,
      message: message,
    );
  }
}

/// **🔹 Shared Preferences Failure**
class SharedPrefsFailure extends Failure {
  const SharedPrefsFailure({required String message})
      : super(message: message);
}
