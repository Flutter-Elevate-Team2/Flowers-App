class AppErrorMessages {
  // ================= NETWORK & DIO =================
  static const String connectionTimeoutError = "Connection timeout. Please check your internet.";
  static const String sendTimeoutError = "Request timeout. Please try again.";
  static const String receiveTimeoutError = "Server took too long to respond.";
  static const String connectionError = "Connection error. Please check your network.";
  static const String noInternetError = "No internet connection.";
  static const String networkError = "Network error occurred.";
  static const String requestCancelledError = "Request was cancelled.";
  static const String badCertificateError = "Security certificate error.";

  // ================= HTTP STATUS CODES =================
  static const String badRequestError = "Invalid request.";
  static const String unauthorizedError = "Session expired. Please login again.";
  static const String forbiddenError = "Access denied.";
  static const String notFoundError = "Resource not found.";
  static const String conflictError = "Data conflict occurred.";
  static const String internalServerError = "Server error. Try again later.";
  static const String serviceUnavailableError = "Service unavailable.";

  // ================= DATA & LOGIC =================
  static const String formatExceptionError = "Data format error.";
  static const String parsingError = "Error parsing data. Please try again.";

  // ================= FIREBASE AUTH =================
  static const String firebaseUserNotFound = "No user found for this email.";
  static const String firebaseWrongPassword = "Wrong password.";
  static const String firebaseEmailInUse = "Email already in use.";
  static const String firebaseInvalidEmail = "Invalid email format.";
  static const String firebaseWeakPassword = "Password is too weak.";
  static const String firebaseAccountDisabled = "Account disabled.";
  static const String firebaseTooManyRequests = "Too many requests. Try again later.";
  static const String firebaseAuthUnknown = "Authentication failed.";

  // ================= FIREBASE GENERAL =================
  static const String firebasePermissionDenied = "Permission denied.";
  static const String firebaseUnavailable = "Firebase service unavailable.";

  // ================= LOCAL STORAGE =================
  static const String hiveError = "Database error (Hive).";
  static const String platformError = "System error occurred.";

  // ================= GENERIC / FALLBACK =================
  static const String defaultError = "Something went wrong.";
  static const String unknownError = "An unexpected error occurred.";
}
