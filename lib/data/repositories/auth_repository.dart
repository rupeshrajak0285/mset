import 'dart:convert';
import 'package:App/common_libraries.dart';

class AuthRepository extends BaseRepository {
  /// Login user with email, password, and role
  Future<LoginResponseModel> userLogin(LoginRequestModel request) async {
    try {
      final response = await postRequest(
        "/login",
        data: request.toJson(),
      );

      if (response.statusCode == 200 && response.data != null) {
        // 🔹 Ensure response is a Map
        final Map<String, dynamic> responseData =
        response.data is String ? jsonDecode(response.data) : response.data;

        if (responseData["error"] != null) {
          throw Exception(responseData["error"]); // clean API error
        }
        return LoginResponseModel.fromJson(responseData);
      } else {
        throw Exception("Login failed with status: ${response.statusCode}");
      }
    } catch (e) {
      if (e is DioException) {
        final rawData = e.response?.data;
        final Map<String, dynamic>? errorData =
        rawData is String ? jsonDecode(rawData) : rawData;

        final errorMessage = errorData?["error"] ??
            errorData?["message"] ??
            e.message ??
            "Something went wrong during login.";
        throw Exception(errorMessage);
      }
      throw Exception(e.toString());
    }
  }

  /// Signup user
  Future<LoginResponseModel> userSignup(SignupRequestModel request) async {
    try {
      final response = await postRequest(
        "/register",
        data: request.toJson(),
      );

      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> responseData =
        response.data is String ? jsonDecode(response.data) : response.data;

        if (responseData["error"] != null) {
          throw Exception(responseData["error"]);
        }
        return LoginResponseModel.fromJson(responseData);
      } else {
        throw Exception("Signup failed with status: ${response.statusCode}");
      }
    } catch (e) {
      if (e is DioException) {
        final rawData = e.response?.data;
        final Map<String, dynamic>? errorData =
        rawData is String ? jsonDecode(rawData) : rawData;

        final errorMessage = errorData?["error"] ??
            errorData?["message"] ??
            e.message ??
            "Something went wrong during signup.";
        throw Exception(errorMessage);
      }
      throw Exception(e.toString());
    }
  }
}
