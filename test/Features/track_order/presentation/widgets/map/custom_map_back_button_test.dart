import 'package:flowers_app/Features/track_order/presentation/widgets/map/custom_map_back_button.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CustomMapBackButton Widget Tests', () {

    testWidgets('should render correctly with correct icon and colors', (tester) async {
       await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomMapBackButton(),
          ),
        ),
      );

      // Assert:
      expect(find.byIcon(Icons.arrow_back_ios_new), findsOneWidget);

      // Assert:
      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, AppColors.mainColor);
      expect(decoration.shape, BoxShape.circle);
    });

    testWidgets('should pop the navigator when tapped', (tester) async {
      // Arrange:
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CustomMapBackButton()),
                ),
                child: const Text('Push'),
              ),
            ),
          ),
        ),
      );

       await tester.tap(find.text('Push'));
      await tester.pumpAndSettle();
      expect(find.byType(CustomMapBackButton), findsOneWidget);

      // Act:
      await tester.tap(find.byType(CustomMapBackButton));
      await tester.pumpAndSettle();

      // Assert:
      expect(find.byType(CustomMapBackButton), findsNothing);
      expect(find.text('Push'), findsOneWidget);
    });

    testWidgets('should have correct padding and icon size', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomMapBackButton(),
          ),
        ),
      );

      // Assert:
      final icon = tester.widget<Icon>(find.byIcon(Icons.arrow_back_ios_new));
      expect(icon.size, 18);
      expect(icon.color, AppColors.white);

      // Assert:
      final container = tester.widget<Container>(find.byType(Container));
      expect(container.padding, const EdgeInsets.all(10));
    });
  });
}