import 'package:flowers_app/Features/commerce/presentation/products/widgets/search_and_filter/product_search_field.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/search_and_filter/search.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/search_and_filter/search_filter_button.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late TextEditingController searchController;

  setUp(() {
    searchController = TextEditingController();
  });

  Widget createWidgetUnderTest({
    required VoidCallback onFilterTap,
    ValueChanged<bool>? onFocusChange,
  }) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: SearchAndFilterBar(
          searchController: searchController,
          onFocusChange: onFocusChange,
          onFilterTap: onFilterTap,
        ),
      ),
    );
  }

  group('SearchAndFilterBar Widget Tests', () {
    testWidgets('Initial State: renders search field and filter button', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(onFilterTap: () {}));

      expect(find.byType(ProductSearchField), findsOneWidget);
      expect(find.byType(SearchFilterButton), findsOneWidget);
    });

    testWidgets('Interaction: triggers onFilterTap when filter button is clicked', (tester) async {
      bool filterTapped = false;
      await tester.pumpWidget(createWidgetUnderTest(
        onFilterTap: () => filterTapped = true,
      ));

      await tester.tap(find.byType(SearchFilterButton));
      expect(filterTapped, isTrue);
    });

    testWidgets('Interaction: triggers onFocusChange when search field gains focus', (tester) async {
      bool focusGained = false;
      await tester.pumpWidget(createWidgetUnderTest(
        onFilterTap: () {},
        onFocusChange: (focused) => focusGained = focused,
      ));

      await tester.tap(find.byType(TextField));
      await tester.pump();

      expect(focusGained, isTrue);
    });
  });
}
