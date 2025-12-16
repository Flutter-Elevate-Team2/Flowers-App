import 'dart:async';
import 'package:injectable/injectable.dart';

@singleton
class SessionController {
  final StreamController<void> _sessionExpiredController = StreamController<void>.broadcast();
  Stream<void> get onSessionExpired => _sessionExpiredController.stream;

  void expireSession() {
    if (!_sessionExpiredController.isClosed) {
      _sessionExpiredController.add(null);
    }
  }
}
