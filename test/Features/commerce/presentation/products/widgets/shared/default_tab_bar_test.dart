import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/default_tab_bar.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/shimmers/categories_tabs_shimmer.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidgetUnderTest({
    required List<String> tabs,
    bool isLoading = false,
    ValueChanged<int>? onTap,
    TabController? controller,
  }) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: DefaultTabBar(
                tabs,
                isLoading: isLoading,
                onTap: onTap,
                controller: controller,
              ),
            ),
          ),
          body: TabBarView(children: tabs.map((e) => Container()).toList()),
        ),
      ),
    );
  }

  group('DefaultTabBar Widget Tests', () {
    testWidgets('Initial State: renders tabs with titles', (tester) async {
      final tabs = ['Tab 1', 'Tab 2', 'Tab 3'];
      await tester.pumpWidget(createWidgetUnderTest(tabs: tabs));
      await tester.pump();

      expect(find.text('Tab 1'), findsWidgets);
      expect(find.text('Tab 2'), findsWidgets);
    });

    testWidgets('Loading State: renders CategoriesTabsShimmer when isLoading', (
      tester,
    ) async {
      final tabs = ['', ''];

      await tester.pumpWidget(
        createWidgetUnderTest(tabs: tabs, isLoading: true),
      );

      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(CategoriesTabsShimmer), findsWidgets);
    });

    testWidgets('Interaction: calls onTap when a tab is pressed', (
      tester,
    ) async {
      final tabs = ['Tab 1', 'Tab 2'];
      int? selectedIndex;

      await tester.pumpWidget(
        createWidgetUnderTest(
          tabs: tabs,
          onTap: (index) => selectedIndex = index,
        ),
      );
      await tester.pump();

      await tester.tap(find.text('Tab 2'));

      await tester.pump(const Duration(milliseconds: 300));

      expect(selectedIndex, 1);
    });
  });
}
