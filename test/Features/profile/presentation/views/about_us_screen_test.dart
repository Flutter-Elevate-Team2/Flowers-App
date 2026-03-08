import 'dart:convert';
import 'package:flowers_app/Features/profile/presentation/views/about_us_screen.dart';
import 'package:flutter/material.dart';
 import 'package:flutter_test/flutter_test.dart';

 class MockAssetBundle extends Fake implements AssetBundle {
  @override
  Future<String> loadString(String key, {bool cache = true}) async {
     final mockData = {
      "about": [
        {
          "section": "Test Section",
          "content": {"en": "Hello", "ar": "أهلاً"},
          "style": {"fontSize": 14}
        }
      ]
    };
    return json.encode(mockData);
  }
}

void main() {
  group('AboutUsScreen Widget Tests (No Code Changes)', () {


    testWidgets('should show loading indicator initially', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DefaultAssetBundle(
            bundle: MockAssetBundle(),
            child: const AboutUsScreen(),
          ),
        ),
      );

       expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}