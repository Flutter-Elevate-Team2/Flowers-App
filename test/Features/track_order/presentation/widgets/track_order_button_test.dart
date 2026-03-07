import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowers_app/Features/track_order/presentation/widgets/track_order_button.dart';
import 'package:flowers_app/core/widget/custom_button.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';

void main() {
  Widget createWidget({required bool isDelivered}) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: TrackOrderButton(isDelivered: isDelivered),
      ),
    );
  }

  group('TrackOrderButton Widget Test', () {
    testWidgets('shows single button when isDelivered is false', (tester) async {
      await tester.pumpWidget(createWidget(isDelivered: false));

       expect(find.byType(CustomButton), findsOneWidget);

       expect(find.text('Show map'), findsOneWidget);
    });

    testWidgets('shows two buttons when isDelivered is true', (tester) async {
      await tester.pumpWidget(createWidget(isDelivered: true));

      // تحقق من وجود زرين
      expect(find.byType(CustomButton), findsNWidgets(2));

      // استخدم context لقراءة النصوص
      final BuildContext context = tester.element(find.byType(TrackOrderButton));

      expect(find.text(context.l10n.showMap), findsOneWidget);
      expect(find.text(context.l10n.orderDelivered), findsOneWidget);
    });  });
}