import 'package:flowers_app/Features/track_order/presentation/widgets/driver_info.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  const driverName = "Ahmed";

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Scaffold(
        body: DriverInfo(name: driverName , phone: "",),
      ),
    );
  }

  group('DriverInfo Widget Test', () {

    testWidgets('should display driver name', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text(driverName), findsOneWidget);
    });

    testWidgets('should display delivery text', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.textContaining('delivery'), findsOneWidget);
    });

    testWidgets('should display call and whatsapp icons', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byIcon(Icons.call_outlined), findsOneWidget);

      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is FaIcon &&
              widget.icon == FontAwesomeIcons.whatsapp,
        ),
        findsOneWidget,
      );
    });

    testWidgets('should have two IconButtons', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(IconButton), findsNWidgets(2));
    });

  });
}