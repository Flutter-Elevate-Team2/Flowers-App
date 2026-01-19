import 'package:dio/dio.dart';
import 'package:flowers_app/core/constants/api_constants.dart';
import 'package:flowers_app/core/controller/session_controller.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class AuthInterceptor extends Interceptor {
  final SharedPreferences _prefs;
  final SessionController _sessionController;
  bool _isLoggingOut = false; // Add this field

  AuthInterceptor(this._prefs, this._sessionController);

  final _publicPaths = [
    ApiConstants.signIn,
    ApiConstants.signUp,
    ApiConstants.forgetPassword,
    ApiConstants.verifyResetCode,
    ApiConstants.resetPassword,
  ];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    bool isPublicPath = _publicPaths.any((path) => options.path.endsWith(path));

    if (!isPublicPath) {
      final token = _prefs.getString(ApiConstants.tokenKey);

      if (token != null && token.isNotEmpty) {
        options.headers["Authorization"] = "Bearer $token";
      }
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !_isLoggingOut) {
      bool isPublicPath = _publicPaths.any(
        (path) => err.requestOptions.path.endsWith(path),
      );

      // Don't logout for change password - 401 means incorrect current password
      bool isChangePassword = err.requestOptions.path.endsWith(
        ApiConstants.changePassword,
      );

      if (!isPublicPath && !isChangePassword) {
        _isLoggingOut = true; // Set flag
        await _performLogout();
        _isLoggingOut = false; // Reset flag
      }
    }
    return handler.next(err);
  }

  Future<void> _performLogout() async {
    // Change to async
    await _prefs.remove(ApiConstants.tokenKey);
    _sessionController.expireSession();
  }
}
