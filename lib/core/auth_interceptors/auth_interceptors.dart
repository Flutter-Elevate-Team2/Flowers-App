import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';
import 'package:flowers_app/core/controller/session_controller.dart';
import 'package:flowers_app/core/constants/api_constants.dart';

@injectable
class AuthInterceptor extends Interceptor {
  final SharedPreferences _prefs;
  final SessionController _sessionController;

  AuthInterceptor(this._prefs, this._sessionController);

  // TODO: [IMPORTANT] Add all public endpoints here (endpoints that DON'T require a token).
  // Example: Login, Signup, ForgetPassword, Public Home Data, etc.
  final _publicPaths = [
    ApiConstants.login,
    ApiConstants.signup,
    // TODO: Add other public paths from ApiConstants when created
    // ApiConstants.forgetPassword,
    // ApiConstants.checkEmail,
  ];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Check if the current path is public
    bool isPublicPath = _publicPaths.any((path) => options.path.endsWith(path));

    if (!isPublicPath) {
      // TODO: Check the key name in SharedPreferences (is it 'token', 'access_token', or 'userToken'?)
      final token = _prefs.getString('token');

      if (token != null && token.isNotEmpty) {
        // TODO: Verify Header Format with Backend Developer
        // Some backends need "Bearer $token", others just "$token", others need "token": "$token"
        options.headers["Authorization"] = "Bearer $token";
      }
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      bool isPublicPath = _publicPaths.any(
        (path) => err.requestOptions.path.endsWith(path),
      );

      if (!isPublicPath) {
        // Session Expired logic
        _sessionController.expireSession();
      }
    }
    return handler.next(err);
  }
}
