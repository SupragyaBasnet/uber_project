import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio dio;
  final SharedPreferences prefs;

  ApiService(this.dio, this.prefs) {
    dio.options = BaseOptions(
      baseUrl: "http://10.0.2.2:3000/api/v1/",
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {"Content-Type": "application/json"},
    );

    dio.interceptors.addAll([
      AuthInterceptor(prefs), // ✅ Fix: Pass SharedPreferences
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    ]);
  }

  Future<Response> getRequest(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    try {
      return await dio.get(endpoint, queryParameters: queryParams);
    } on DioException catch (e) {
      throw Exception("GET Request failed: ${e.response?.data ?? e.message}");
    }
  }

  Future<Response> postRequest(String endpoint,
      {Map<String, dynamic>? data}) async {
    try {
      return await dio.post(endpoint, data: data);
    } on DioException catch (e) {
      throw Exception("POST Request failed: ${e.response?.data ?? e.message}");
    }
  }

  Future<Response> putRequest(String endpoint,
      {Map<String, dynamic>? data}) async {
    try {
      return await dio.put(endpoint, data: data);
    } on DioException catch (e) {
      throw Exception("PUT Request failed: ${e.response?.data ?? e.message}");
    }
  }

  Future<Response> deleteRequest(String endpoint) async {
    try {
      return await dio.delete(endpoint);
    } on DioException catch (e) {
      throw Exception("DELETE Request failed: ${e.response?.data ?? e.message}");
    }
  }
}

// ✅ Fix: Make AuthInterceptor use dependency injection
class AuthInterceptor extends Interceptor {
  final SharedPreferences prefs;

  AuthInterceptor(this.prefs);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = prefs.getString("token");

    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      print("Unauthorized request - Redirect to login");
      // You can trigger logout logic here
    }
    super.onError(err, handler);
  }
}
