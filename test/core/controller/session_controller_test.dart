import 'package:flowers_app/core/controller/session_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late SessionController sessionController;

  setUp(() {
    sessionController = SessionController();
  });

  tearDown(() {
    sessionController.dispose();
  });

  group('SessionController', () {
    test('expireSession emits event', () async {
      expectLater(sessionController.onSessionExpired, emits(null));
      sessionController.expireSession();
    });

    test('notifyLogin emits event', () async {
      expectLater(sessionController.onLogin, emits(null));
      sessionController.notifyLogin();
    });

    test('notifyLogout emits reason', () async {
      expectLater(sessionController.onLogout, emits(SessionEndReason.logout));
      sessionController.notifyLogout(SessionEndReason.logout);
    });

    test('multiple listeners receive events (broadcast)', () async {
      int listener1Count = 0;
      int listener2Count = 0;

      final sub1 = sessionController.onLogin.listen((_) => listener1Count++);
      final sub2 = sessionController.onLogin.listen((_) => listener2Count++);

      sessionController.notifyLogin();

      await Future.delayed(Duration.zero);

      expect(listener1Count, 1);
      expect(listener2Count, 1);

      await sub1.cancel();
      await sub2.cancel();
    });
  });
}
