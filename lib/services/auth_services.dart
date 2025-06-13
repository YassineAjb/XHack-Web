import 'dart:convert';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;

class AuthService {
  /// Login
  static Future<http.Response> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('${AppConstants.baseUrl}/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    return response;
  }

  /// Forgot Password (Send OTP)
  static Future<http.Response> forgotPassword(String email) async {
    final response = await http.post(
      Uri.parse('${AppConstants.baseUrl}/forgot-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
    return response;
  }

  /// Verify OTP
  static Future<http.Response> verifyOtp(String otpCode) async {
    final response = await http.post(
      Uri.parse('${AppConstants.baseUrl}/verify-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'recoveryCode': otpCode}),
    );
    return response;
  }

  /// Reset Password
  static Future<http.Response> resetPassword(String newPassword, String resetToken) async {
    final response = await http.put(
      Uri.parse('${AppConstants.baseUrl}/reset-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'newPassword': newPassword,
        'resetToken': resetToken,
      }),
    );
    return response;
  }
}
