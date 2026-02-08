import 'dart:async';
import 'package:injectable/injectable.dart';

@singleton
class SessionController {
  // Fix: Use broadcast if multiple listeners are expected, or keep standard.
  // Adding dispose method is crucial.
  final StreamController<void> _sessionExpiredController = StreamController<void>.broadcast();

  Stream<void> get onSessionExpired => _sessionExpiredController.stream;

  void expireSession() {
    if (!_sessionExpiredController.isClosed) {
      _sessionExpiredController.add(null);
    }
  }

  final StreamController<void> _loginController =
  StreamController<void>.broadcast();

  final StreamController<void> _logoutController =
  StreamController<void>.broadcast();

  Stream<void> get onLogin => _loginController.stream;
  Stream<void> get onLogout => _logoutController.stream;

  void notifyLogin() {
    if (!_loginController.isClosed) {
      _loginController.add(null);
    }
  }

  void notifyLogout() {
    if (!_logoutController.isClosed) {
      _logoutController.add(null);
    }
  }

  // Fix: Added dispose method
  @disposeMethod
  void dispose() {
    _sessionExpiredController.close();
    _loginController.close();
    _logoutController.close();
  }
}
