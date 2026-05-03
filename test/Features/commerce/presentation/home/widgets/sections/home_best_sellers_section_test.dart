import 'package:flowers_app/Features/commerce/domain/entities/product_entities/best_seller_entity.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/items/product_item.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/sections/home_best_sellers_section.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/shared/section_header.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

void main() {
  late List<BestSellerEntity> testBestSellers;

  setUp(() {
    testBestSellers = [
      BestSellerEntity(
        id: '1',
        name: 'Red Rose',
        price: 50.0,
        imageUrl: 'http://rose.png',
        description: 'A beautiful red rose',
        images: ['http://rose.png'],
        priceAfterDiscount: 45,
        quantity: 10,
        discount: 10,
      ),
    ];
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: HomeBestSellersSection(
          bestSellers: testBestSellers,
          screenWidth: 375,
        ),
      ),
    );
  }

  group('HomeBestSellersSection Widget Tests', () {
    testWidgets('Initial State: renders section header and correct number of items', (tester) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(createWidgetUnderTest());

        // بدلاً من pumpAndSettle، ننتظر فترات محددة
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));

        expect(find.byType(SectionHeader), findsOneWidget);
        expect(find.byType(ProductItem), findsNWidgets(testBestSellers.length));
      });
    });

    testWidgets('Empty State: renders nothing when bestSellers list is empty', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(
            body: HomeBestSellersSection(
              bestSellers: [],
              screenWidth: 375,
            ),
          ),
        ),
      );

      expect(find.byType(Column), findsNothing);
    });
  });
}
