import 'package:flowers_app/Features/commerce/domain/entities/home_entities/home_entity.dart';
import 'package:flowers_app/Features/commerce/domain/entities/product_entities/best_seller_entity.dart';
import 'package:flowers_app/Features/commerce/presentation/home/sections/home_section.dart';
import 'package:flowers_app/Features/commerce/presentation/home/sections/implementations/best_sellers_section.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/sections/home_best_sellers_section.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeEntity extends Mock implements HomeEntity {}

void main() {
  late BestSellersSection section;
  late MockHomeEntity mockData;

  setUp(() {
    section = BestSellersSection();
    mockData = MockHomeEntity();
  });

  Widget createWidgetUnderTest(Widget child) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    );
  }

  group('BestSellersSection Logic Tests', () {
    test('should have correct section type', () {
      expect(section.type, HomeSectionType.bestSellers);
    });

    test('isVisible should return true when bestSellers is NOT empty', () {
      when(() => mockData.bestSellers).thenReturn([
        BestSellerEntity(
          id: '1',
          name: '',
          price: 0,
          imageUrl: '',
          description: '',
          images: [],
          priceAfterDiscount: 0,
          quantity: 0,
          discount: 0,
        ),
      ]);

      expect(section.isVisible(mockData), isTrue);
    });

    test('isVisible should return false when bestSellers is empty', () {
      when(() => mockData.bestSellers).thenReturn([]);

      expect(section.isVisible(mockData), isFalse);
    });
  });

  group('BestSellersSection Widget Tests', () {
    testWidgets('should build HomeBestSellersSection with correct data', (
      tester,
    ) async {
      final testProducts = [
        BestSellerEntity(
          id: '1',
          name: 'Rose',
          price: 10,
          imageUrl: '',
          description: '',
          images: [],
          priceAfterDiscount: 0,
          quantity: 0,
          discount: 0,
        ),
      ];

      when(() => mockData.bestSellers).thenReturn(testProducts);

      await tester.pumpWidget(
        createWidgetUnderTest(
          Builder(builder: (context) => section.build(context, mockData)),
        ),
      );

      await tester.pump();

      expect(find.byType(HomeBestSellersSection), findsOneWidget);

      final widget = tester.widget<HomeBestSellersSection>(
        find.byType(HomeBestSellersSection),
      );
      expect(widget.bestSellers, testProducts);
    });
  });
}
