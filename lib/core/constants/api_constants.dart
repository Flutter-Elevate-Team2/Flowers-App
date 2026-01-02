
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String apiBaseUrl = dotenv.env['BASE_URL'] ?? "";

  // ================= Auth Endpoints =================
  static const String signIn = "/auth/signin";
  static const String signUp = "/auth/signup";
  static const String forgetPassword = "/auth/forgotPassword";
  static const String resetPassword = "/auth/resetPassword";
  static const String verifyResetCode = "/auth/verifyResetCode";
}
