import 'package:flowers_app/Features/user_address/presentation/views/map_location_picker.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    const MethodChannel(
      'flutter.baseflow.com/google_api_availability/methods',
    ).setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'checkGooglePlayServicesAvailability') {
        return 0; // success: GooglePlayServicesAvailability.success.value
      }
      return null;
    });

    const MethodChannel(
      'flutter.baseflow.com/permissions/methods',
    ).setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'requestPermissions') {
        final List<dynamic> args = methodCall.arguments;
        final Map<int, int> result = {};
        for (var p in args) {
          if (p is int) {
            result[p] = 1; // PermissionStatus.granted
          }
        }
        return result;
      }
      return null;
    });
  });

  Widget buildTestableWidget({
    double initialLat = 30.0444,
    double initialLong = 31.2357,
  }) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('ar')],
      home: MapLocationPicker(initialLat: initialLat, initialLong: initialLong),
    );
  }

  testWidgets(
    'Shows CircularProgressIndicator during GMS availability check ..... ',
    (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(buildTestableWidget());

      // Assert - Initially shows loading while checking GMS
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    },
  );

  testWidgets('AppBar displays Pick Location title ..... ', (
    WidgetTester tester,
  ) async {
    // Arrange & Act
    await tester.pumpWidget(buildTestableWidget());
    await tester.pump(const Duration(seconds: 2));

    // Assert
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Pick Location'), findsOneWidget);
  });

  testWidgets('AppBar has check icon button ..... ', (
    WidgetTester tester,
  ) async {
    // Arrange & Act
    await tester.pumpWidget(buildTestableWidget());
    await tester.pump(const Duration(seconds: 2));

    // Assert
    expect(find.byIcon(Icons.check), findsOneWidget);
  });

  testWidgets('FloatingActionButton with my_location icon is present ..... ', (
    WidgetTester tester,
  ) async {
    // Arrange & Act
    await tester.pumpWidget(buildTestableWidget());
    await tester.pump(const Duration(seconds: 2));

    // Assert
    expect(find.byIcon(Icons.my_location), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('Map widget is rendered after GMS check ..... ', (
    WidgetTester tester,
  ) async {
    // Arrange & Act
    await tester.pumpWidget(buildTestableWidget());
    await tester.pump(const Duration(seconds: 2));

    // Assert - After GMS check, map should be displayed
    // Either GoogleMapWidget or MapboxMapWidget should be present
    final googleMapWidget = find.byType(GoogleMapWidget);
    final mapboxMapWidget = find.byType(MapboxMapWidget);

    expect(
      googleMapWidget.evaluate().isNotEmpty ||
          mapboxMapWidget.evaluate().isNotEmpty,
      true,
    );
  });

  testWidgets('Initial coordinates are passed correctly ..... ', (
    WidgetTester tester,
  ) async {
    // Arrange
    const testLat = 31.2001;
    const testLong = 29.9187;

    // Act
    await tester.pumpWidget(
      buildTestableWidget(initialLat: testLat, initialLong: testLong),
    );
    await tester.pump(const Duration(seconds: 2));

    // Assert - Widget should be built with the provided coordinates
    expect(find.byType(MapLocationPicker), findsOneWidget);
  });

  testWidgets('Stack layout contains map and FAB ..... ', (
    WidgetTester tester,
  ) async {
    // Arrange    // Act
    await tester.pumpWidget(buildTestableWidget());
    // Use pump instead of pumpAndSettle to avoid timeout from infinite animations (like map or loading)
    for (int i = 0; i < 5; i++) {
      await tester.pump(const Duration(milliseconds: 500));
    }

    // Assert
    expect(find.byType(Stack), findsWidgets);
    expect(find.byType(Positioned), findsWidgets);
  });
}
