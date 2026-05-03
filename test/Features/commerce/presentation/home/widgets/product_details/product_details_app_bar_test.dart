import 'package:flowers_app/Features/commerce/presentation/home/widgets/product_details/product_details_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  late PageController testController;
  final List<String> testImages = [
    'https://example.com/image1.jpg',
    'https://example.com/image2.jpg'
  ];

  setUp(() {
    testController = PageController();
  });

  tearDown(() {
    testController.dispose();
  });

  Widget createWidgetUnderTest({
    List<String>? images,
    Color bgColor = Colors.white,
    Function(int)? onPageChanged,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            ProductDetailsAppBar(
              controller: testController,
              images: images ?? testImages,
              backgroundColor: bgColor,
              onPageChanged: onPageChanged ?? (_) {},
            ),
          ],
        ),
      ),
    );
  }

  group('ProductDetailsAppBar Tests', () {
    testWidgets('renders PageView and SmoothPageIndicator when multiple images exist', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(PageView), findsOneWidget);
      expect(find.byType(SmoothPageIndicator), findsOneWidget);
    });

    testWidgets('shows placeholder icon when images list is empty', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(images: []));

      expect(find.byIcon(Icons.image_not_supported), findsOneWidget);
      // لا يجب أن يظهر الـ Indicator إذا كانت هناك صورة واحدة (أو لا يوجد)
      expect(find.byType(SmoothPageIndicator), findsNothing);
    });

    testWidgets('AnimatedContainer has correct background color', (tester) async {
      const targetColor = Colors.red;
      await tester.pumpWidget(createWidgetUnderTest(bgColor: targetColor));

      final animatedContainer = tester.widget<AnimatedContainer>(
          find.byType(AnimatedContainer)
      );

      expect(animatedContainer.decoration, isA<BoxDecoration>().having(
              (d) => d.color, 'color', targetColor
      ));
    });
  });
}