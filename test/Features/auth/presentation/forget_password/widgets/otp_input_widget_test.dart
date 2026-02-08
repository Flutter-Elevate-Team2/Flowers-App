import 'package:flowers_app/Features/auth/presentation/forget_password/widgets/otp_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pinput/pinput.dart';

void main() {
  Widget createWidgetUnderTest(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }

  group('OtpInputWidget Tests', () {
    testWidgets('Calls onCompleted when all digits are entered', (tester) async {
      String? enteredOtp;

      await tester.pumpWidget(createWidgetUnderTest(
        OtpInputWidget(
          length: 6,
          onCompleted: (val) {
            enteredOtp = val;
          },
        ),
      ));

      // Pinput usually works with text input.
      // We find the TextField inside Pinput and enter text.
      await tester.enterText(find.byType(Pinput), '123456');
      await tester.pump();

      expect(enteredOtp, equals('123456'));
    });

    testWidgets('Displays error text when errorText is provided', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        OtpInputWidget(
          onCompleted: (_) {},
          errorText: 'Invalid Code',
        ),
      ));

      expect(find.text('Invalid Code'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });
  });
}
