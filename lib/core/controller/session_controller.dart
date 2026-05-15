import 'dart:async';
import 'package:injectable/injectable.dart';

enum SessionEndReason { logout, guest, passwordChanged }

@singleton
class SessionController {
  // Fix: Use broadcast if multiple listeners are expected, or keep standard.
  // Adding dispose method is crucial.
  final StreamController<void> _sessionExpiredController =
      StreamController<void>.broadcast();

  Stream<void> get onSessionExpired => _sessionExpiredController.stream;

  void expireSession() {
    if (!_sessionExpiredController.isClosed) {
      _sessionExpiredController.add(null);
    }
  }

  final StreamController<void> _loginController =
      StreamController<void>.broadcast();

  final StreamController<SessionEndReason> _logoutController =
  StreamController<SessionEndReason>.broadcast();

  Stream<void> get onLogin => _loginController.stream;
  Stream<SessionEndReason> get onLogout => _logoutController.stream;

  void notifyLogin() {
    if (!_loginController.isClosed) {
      _loginController.add(null);
    }
  }

  void notifyLogout(SessionEndReason reason) {
    if (!_logoutController.isClosed) {
      _logoutController.add(reason);
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
