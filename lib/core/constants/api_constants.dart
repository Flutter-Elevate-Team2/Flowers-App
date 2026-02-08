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
  static const String getProfile = "/auth/profile-data";
  static const String editProfile = "/auth/editProfile";
  static const String uploadPhoto = "auth/upload-photo";
  static const String changePassword = "/auth/change-password";
  static const String logout = "/auth/logout";

  // ================= Products Endpoints =================
  static const String getProducts = "/products";
  static const int defaultCurrentPage = 1;
  static const int defaultLimit = 40;
  static const int defaultTotalPages = 1;
  static const int defaultTotalItems = 0;
  static const String tokenKey = "user_token";

  // ================= Cart Endpoints =================
  static const String cart = "/cart";

  // ================= Address Endpoints =================
  static const String addresses = "/addresses";

  // ================= Checkout Endpoints =================
  static const String orders = "/orders";
  static const String success = "success";
  static const String cancel = "cancel";
  static const String fail = "fail";
  static const String allOrders = "allOrders";
  // ================= Notifications Endpoints =================
  static const String notifications = "notifications/user";
}
