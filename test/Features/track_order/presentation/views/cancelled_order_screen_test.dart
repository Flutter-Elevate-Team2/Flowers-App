import 'package:flowers_app/Features/track_order/presentation/views/cancelled_order_screen.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flowers_app/core/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

void main() {
  const tOrderId = "order_999";

   Widget createWidgetUnderTest() {
    final router = GoRouter(
      initialLocation: '/home',
      routes: [
        GoRoute(
          path: '/home',
          name: Routes.homeName,
          builder: (context, state) => const Scaffold(body: Text('Home Page')),
        ),
        GoRoute(
          path: '/cancelled',
          name: Routes.cancelledOrderName,
          builder: (context, state) => const CancelledOrderScreen(orderId: tOrderId),
        ),
      ],
    );

    return MaterialApp.router(
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }

  group('CancelledOrderScreen Widget Tests', () {

    testWidgets('Should display Lottie error animation and cancellation messages', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

       final BuildContext context = tester.element(find.text('Home Page'));
      context.pushNamed(Routes.cancelledOrderName);

       await tester.pumpAndSettle();

      expect(find.byType(Lottie), findsOneWidget);

      final l10n = AppLocalizations.of(context)!;
      expect(find.text(l10n.orderCancelled), findsOneWidget);
    });    testWidgets('Should navigate to Home when Reorder button is pressed', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

       final BuildContext context = tester.element(find.text('Home Page'));
      context.pushNamed(Routes.cancelledOrderName);
      await tester.pumpAndSettle();

      await tester.tap(find.byType(CustomButton));
      await tester.pumpAndSettle();

      expect(find.text('Home Page'), findsOneWidget);
    });

    testWidgets('Should pop the screen when back icon is pressed', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

       final BuildContext context = tester.element(find.text('Home Page'));
      context.pushNamed(Routes.cancelledOrderName);
      await tester.pumpAndSettle();

       await tester.tap(find.byIcon(Icons.arrow_back_ios));
      await tester.pumpAndSettle();

      expect(find.byType(CancelledOrderScreen), findsNothing);
    });
  });
}