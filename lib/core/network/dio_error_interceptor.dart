import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage = _handleDioError(err);

    // Log error to console
    debugPrint("Dio Error: $errorMessage");

    // Forward the error to be handled by the calling function
    handler.reject(err);
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection timed out. Please check your internet.";

      case DioExceptionType.sendTimeout:
        return "Request timed out. Please try again.";

      case DioExceptionType.receiveTimeout:
        return "Server took too long to respond.";

      case DioExceptionType.badResponse:
        return _handleHttpError(error.response);

      case DioExceptionType.cancel:
        return "Request was cancelled.";

      case DioExceptionType.unknown:
        return "An unexpected error occurred. Please try again.";

      default:
        return "Something went wrong. Please try again.";
    }
  }

  String _handleHttpError(Response? response) {
    if (response == null) {
      return "No response from server.";
    }

    switch (response.statusCode) {
      case 400:
        return "Bad request. Please check your input.";
      case 401:
        return "Unauthorized. Please log in again.";
      case 403:
        return "Access denied.";
      case 404:
        return "Requested resource not found.";
      case 500:
        return "Internal server error. Please try again later.";
      default:
        return "Server error: ${response.statusCode}.";
    }
  }
}
