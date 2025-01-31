import 'dart:io';
import 'package:dio/dio.dart';
import 'package:uber_mobile_app_project/core/error/failure.dart';
import '../../app/constants/api_endpoints.dart';
import 'hive_service.dart';

class ApiService {
  final Dio _dio;
  final HiveService _hiveService;

  ApiService(this._dio, this._hiveService);

  // ==============================
  // 🚀 Generic API Request Handler
  // ==============================
  Future<Response> _request(
      String endpoint, {
        String method = 'GET',
        Map<String, dynamic>? data,
        Map<String, dynamic>? queryParams,
        bool requiresAuth = true,
      }) async {
    try {
      Options options = Options(
        method: method,
        headers: {},
      );

      // Attach authentication token if required
      if (requiresAuth) {
        final token = _hiveService.getData('authBox', 'token');
        if (token != null) {
          options.headers!['Authorization'] = 'Bearer $token';
        }
      }

      Response response = await _dio.request(
        endpoint,
        data: data,
        queryParameters: queryParams,
        options: options,
      );

      return response;
    } catch (error) {
      if (error is DioException) {
        throw ApiFailure(
          message: error.response?.data['message'] ?? 'API Error',
          statusCode: error.response?.statusCode,
        );
      }
      throw ApiFailure(message: 'Unexpected error occurred.');
    }
  }

  // ==============================
  // 🔐 AUTHENTICATION API CALLS
  // ==============================

  /// **User Login**
  Future<Map<String, dynamic>> userLogin(String phoneNumber, String password) async {
    final response = await _request(
      ApiEndpoints.userLogin,
      method: 'POST',
      data: {
        'phonenumber': phoneNumber,
        'password': password,
      },
      requiresAuth: false,
    );

    return response.data;
  }

  Future<Map<String, dynamic>> userSignup({
    required String firstname,
    required String lastname,
    required String phonenumber,
    required String email,
    required String password,
    String? profileImage,
  }) async {
    final response = await _request(
      ApiEndpoints.userRegister,
      method: 'POST',
      data: {
        'firstname': firstname,
        'lastname': lastname,
        'phonenumber': phonenumber,
        'email': email,
        'password': password,
        if (profileImage != null) 'profileImage': profileImage,
      },
      requiresAuth: false,
    );

    return response.data;
  }
  /// **Captain Login**
  Future<Map<String, dynamic>> captainLogin(String phoneNumber, String password) async {
    final response = await _request(
      ApiEndpoints.captainLogin, // Ensure correct API endpoint
      method: 'POST',
      data: {
        'phonenumber': phoneNumber,
        'password': password,
      },
      requiresAuth: false,
    );

    return response.data;
  }

  /// **Captain Signup (with optional profile image)**
  Future<Map<String, dynamic>> captainSignup({
    required String firstname,
    required String lastname,
    required String phonenumber,
    required String email,
    required String password,
    required String color,
    required String plate,
    required int capacity,
    required String vehicleType,
    String? profileImage,  // ✅ Change from File? to String?
  }) async {
    final response = await _request(
      ApiEndpoints.captainRegister,
      method: 'POST',
      data: {
        'firstname': firstname,
        'lastname': lastname,
        'phonenumber': phonenumber,
        'email': email,
        'password': password,
        'vehicle': {
          'color': color,
          'plate': plate,
          'capacity': capacity,
          'vehicleType': vehicleType,
        },
        if (profileImage != null) 'profileImage': profileImage, // ✅ Correctly passing String URL
      },
      requiresAuth: false,
    );

    return response.data;
  }

  // ==============================
  // 📤 IMAGE UPLOAD FUNCTION
  // ==============================

  /// **Upload User Profile Image**
  Future<String> uploadUserImage(File imageFile) async {
    return await _uploadImage(ApiEndpoints.uploadUserImage, imageFile);
  }

  /// **Upload Captain Profile Image**
  Future<String> uploadCaptainImage(File imageFile) async {
    return await _uploadImage(ApiEndpoints.uploadCaptainImage, imageFile);
  }

  /// **Generic Image Upload Function**
  Future<String> _uploadImage(String endpoint, File imageFile) async {
    try {
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      });

      Response response = await _dio.post(
        endpoint,
        data: formData,
      );

      return response.data['imageUrl']; // ✅ Returns uploaded image URL
    } catch (error) {
      throw ApiFailure(message: "Failed to upload image: ${error.toString()}");
    }
  }

  // ==============================
  // 🔐 FORGOT PASSWORD API CALLS
  // ==============================

  /// **Send OTP**
  Future<String> sendOtp(String email, String userType) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.sendOtp,
        data: {"email": email, "userType": userType},
      );
      return response.data["message"];
    } catch (e) {
      throw ApiFailure(message: "Failed to send OTP");
    }
  }

  /// **Verify OTP**
  Future<String> verifyOtp(String email, String otp) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.verifyOtp,
        data: {"email": email, "otp": otp},
      );
      return response.data["message"];
    } catch (e) {
      throw ApiFailure(message: "Invalid or expired OTP");
    }
  }

  /// **Reset Password**
  Future<String> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
    required String confirmPassword, // ✅ Now correctly passing confirmPassword
    required String userType,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.resetPassword,
        data: {
          "email": email,
          "otp": otp,
          "password": newPassword,
          "confirmPassword": confirmPassword, // ✅ Ensure confirmPassword is passed
          "userType": userType,
        },
      );
      return response.data["message"];
    } catch (e) {
      throw ApiFailure(message: "Failed to reset password");
    }
  }


  // ==============================
  // 🚖 CAPTAIN HOME API CALLS
  // ==============================

  /// **Fetch Captain Home Data**
  Future<Map<String, dynamic>> getCaptainHome() async {
    final response = await _request(ApiEndpoints.captainProfile, method: 'GET');
    return response.data;
  }

  /// **Logout (for both User and Captain)**
  Future<void> logout() async {
    await _request(ApiEndpoints.userLogout, method: 'POST');
    await _hiveService.clearBox('authBox'); // ✅ Clears local storage after logout
  }
}
