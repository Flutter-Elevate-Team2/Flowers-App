class ErrorStrings {
  ErrorStrings._(); // Private constructor to prevent instantiation

  // --- Network Errors ---
  static const String noInternet = "No internet connection.";
  static const String connectionTimeout = "Connection timeout. Please check your internet.";
  static const String sendTimeout = "Request timeout. Please try again.";
  static const String receiveTimeout = "Server took too long to respond.";
  static const String requestCancelled = "Request was cancelled.";
  static const String badCertificate = "Security certificate error.";
  static const String connectionError = "Connection error. Please check your network.";
  static const String networkError = "Network error occurred.";

  // --- HTTP Status Codes ---
  static const String badRequest = "Invalid request.";
  static const String unauthorized = "Session expired. Please login again.";
  static const String forbidden = "Access denied.";
  static const String notFound = "Resource not found.";
  static const String conflict = "Data conflict occurred.";
  static const String internalServerError = "Server error. Try again later.";
  static const String serviceUnavailable = "Service unavailable.";

  // --- Data & Parsing ---
  static const String parsingError = "Error parsing data. Please try again.";
  static const String formatException = "Data format error.";

  // --- Firebase Auth ---
  static const String firebaseUserNotFound = "No user found for this email.";
  static const String firebaseWrongPassword = "Wrong password.";
  static const String firebaseEmailInUse = "Email already in use.";
  static const String firebaseInvalidEmail = "Invalid email format.";
  static const String firebaseWeakPassword = "Password is too weak.";
  static const String firebaseAccountDisabled = "Account disabled.";
  static const String firebaseTooManyRequests = "Too many requests. Try again later.";
  static const String firebaseAuthUnknown = "Authentication failed.";
  static const String resetCodenotVerified = "reset code not verified";
  static const String resetCodeInvalid= 'Reset code is invalid or has expired';

  // --- Firebase General ---
  static const String firebasePermissionDenied = "Permission denied.";
  static const String firebaseUnavailable = "Firebase service unavailable.";

  // --- Local Storage ---
  static const String hiveError = "Database error (Hive).";
  static const String platformError = "System error occurred.";

  // --- Fallback ---
  static const String defaultError = "Something went wrong.";
  static const String unknownError = "An unexpected error occurred.";
  static const String success = "success";

}
