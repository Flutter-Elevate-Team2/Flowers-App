class AppErrorMessages {
  // ================= DIO & NETWORK ERRORS =================
  static const String connectionTimeoutError =
      "Connection timeout. Please check your internet and try again.";
  static const String sendTimeoutError = "Request timeout. Please try again.";
  static const String receiveTimeoutError =
      "Server took too long to respond. Please try again.";
  static const String connectionError =
      "No internet connection. Please check your network.";
  static const String noInternetError =
      "No internet connection. Please check your network.";
  static const String networkError =
      "Network error occurred. Please try again.";
  static const String requestCancelledError = "Request was cancelled.";
  static const String badCertificateError = "Security certificate error (SSL).";

  // ================= HTTP STATUS CODES =================
  static const String badRequestError =
      "Invalid request. Please check your input.";
  static const String unauthorizedError =
      "Session expired. Please login again.";
  static const String forbiddenError =
      "Access denied. You don't have permission.";
  static const String notFoundError = "Resource not found.";
  static const String conflictError =
      "Conflict occurred. Data might already exist.";
  static const String internalServerError =
      "Server error. Please try again later.";
  static const String serviceUnavailableError =
      "Service unavailable. Please try again later.";

  // ================= FIREBASE AUTH ERRORS =================
  static const String firebaseUserNotFound = "No user found for this email.";
  static const String firebaseWrongPassword = "Wrong password provided.";
  static const String firebaseEmailInUse =
      "The account already exists for that email.";
  static const String firebaseInvalidEmail =
      "The email address is badly formatted.";
  static const String firebaseWeakPassword =
      "The password provided is too weak.";
  static const String firebaseAccountDisabled =
      "This user account has been disabled.";
  static const String firebaseTooManyRequests =
      "Too many requests. Try again later.";
  static const String firebaseAuthUnknown =
      "Authentication failed. Please try again.";

  // ================= FIREBASE GENERAL ERRORS =================
  static const String firebasePermissionDenied =
      "You do not have permission to access this data.";
  static const String firebaseUnavailable =
      "Firebase service is currently unavailable.";

  // ================= CACHE & STORAGE ERRORS =================
  static const String cacheError = "Failed to load or save data locally.";
  static const String hiveError = "Database error occurred (Hive).";
  static const String platformError =
      "System error occurred (Platform/SharedPrefs).";

  // ================= GENERIC ERRORS =================
  static const String unknownError = "An unexpected error occurred.";
  static const String defaultError = "Something went wrong. Please try again.";
  static const String formatExceptionError =
      "Data format error. Please contact support.";
}
