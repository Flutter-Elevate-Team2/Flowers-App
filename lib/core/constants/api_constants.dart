import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String apiBaseUrl = dotenv.env['BASE_URL'] ?? "";

  // ================= Auth Endpoints =================
  static const String signIn = "/auth/signin";
  static const String signUp = "/auth/signup";
  static const String forgetPassword = "/auth/forgotPassword";
  static const String resetPassword = "/auth/resetPassword";
  static const String verifyResetCode = "/auth/verifyResetCode";
  static const String home = "/home";
  static const String getProfile = "/profile-data";
  static const String editProfile = "/editProfile";
  static const String uploadPhoto = "/upload-photo";
  static const String changePassword = "/change-password";
  static const String logout = "/auth/logout";

  // ================= Products Endpoints =================
  static const String getProducts = "/products";
  static const int defaultCurrentPage = 1;
  static const int defaultLimit = 40;
  static const int defaultTotalPages = 1;
  static const int defaultTotalItems = 0;
  static const String tokenKey = "user_token";
}
