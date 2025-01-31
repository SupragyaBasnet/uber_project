import 'package:dio/dio.dart';
import 'package:uber_mobile_app_project/core/error/failure.dart';

class DioErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage = 'Something went wrong.';
    int? statusCode;

    if (err.response != null) {
      statusCode = err.response!.statusCode;

      if (statusCode == 400) {
        errorMessage = err.response?.data['message'] ?? 'Bad Request';
      } else if (statusCode == 401) {
        errorMessage = 'Unauthorized. Please login again.';
      } else if (statusCode == 403) {
        errorMessage = 'Forbidden. You do not have access to this resource.';
      } else if (statusCode == 404) {
        errorMessage = 'Resource not found.';
      } else if (statusCode == 500) {
        errorMessage = 'Internal Server Error. Please try again later.';
      } else {
        errorMessage = err.response?.data['message'] ?? 'Unexpected Error.';
      }
    } else {
      if (err.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'Connection timed out. Please check your internet.';
      } else if (err.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'Server took too long to respond.';
      } else if (err.type == DioExceptionType.sendTimeout) {
        errorMessage = 'Request timed out. Please try again.';
      } else if (err.type == DioExceptionType.connectionError) {
        errorMessage = 'No internet connection. Please check your network.';
      } else if (err.type == DioExceptionType.badCertificate) {
        errorMessage = 'SSL Certificate error. Cannot connect to the server.';
      } else if (err.type == DioExceptionType.cancel) {
        errorMessage = 'Request was cancelled.';
      }
    }

    // Log the error
    print('Dio Error [$statusCode]: $errorMessage');

    // Pass the error to Dio's default handler
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: ApiFailure(message: errorMessage, statusCode: statusCode),
      ),
    );
  }
}
