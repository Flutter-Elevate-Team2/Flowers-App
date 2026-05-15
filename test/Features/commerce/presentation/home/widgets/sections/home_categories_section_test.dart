import 'package:flowers_app/Features/commerce/domain/entities/home_entities/category_entity.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/sections/home_categories_section.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/items/category_item.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/shared/section_header.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:go_router/go_router.dart';

void main() {
  late List<CategoryEntity> testCategories;

  setUp(() {
    testCategories = [
      CategoryEntity(id: '1', name: 'Flowers', icon: 'http://img1.png'),
      CategoryEntity(id: '2', name: 'Plants', icon: 'http://img2.png'),
    ];
  });

  Widget createWidgetUnderTest({List<CategoryEntity>? categories}) {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Scaffold(
            body: HomeCategoriesSection(
              categories: categories ?? testCategories,
              screenWidth: 375,
            ),
          ),
        ),
        GoRoute(
          path: '/categories-path',
          name: 'categories',
          builder: (context, state) => const Scaffold(body: Text('Success')),
        ),
      ],
    );

    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }

  group('HomeCategoriesSection Widget Tests', () {
    testWidgets(
      'Initial State: renders section header and correct number of items',
      (tester) async {
        await mockNetworkImages(() async {
          await tester.pumpWidget(createWidgetUnderTest());
          await tester.pump(const Duration(milliseconds: 100));

          expect(find.byType(SectionHeader), findsOneWidget);
          expect(
            find.byType(CategoryItem),
            findsNWidgets(testCategories.length),
          );
        });
      },
    );

    testWidgets('Interaction: tapping on a category item', (tester) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump(const Duration(milliseconds: 100));

        final firstCategory = find.byType(CategoryItem).first;
        expect(firstCategory, findsOneWidget);

        await tester.tap(firstCategory);

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));

      });
    });

    testWidgets('Empty State: renders nothing when categories list is empty', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: HomeCategoriesSection(categories: [], screenWidth: 375),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(Column), findsNothing);
    });
  });
}
