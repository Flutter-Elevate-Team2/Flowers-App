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
      final token = _prefs.getString('token');

      if (token != null && token.isNotEmpty) {
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
        _performLogout();
      }
    }
    return handler.next(err);
  }

  void _performLogout() {
    _prefs.remove('token');
    _sessionController.expireSession();
  }
}
