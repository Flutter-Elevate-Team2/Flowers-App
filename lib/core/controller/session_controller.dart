import 'dart:async';
import 'package:injectable/injectable.dart';

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

  // Fix: Added dispose method
  @disposeMethod
  void dispose() {
    _sessionExpiredController.close();
  }
}
