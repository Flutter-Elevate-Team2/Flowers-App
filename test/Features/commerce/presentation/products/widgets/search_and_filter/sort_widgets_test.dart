import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/commerce/presentation/products/view_model/products_events.dart';
import 'package:flowers_app/Features/commerce/presentation/products/view_model/products_states.dart';
import 'package:flowers_app/Features/commerce/presentation/products/view_model/products_view_model.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/search_and_filter/filter_action_button.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/search_and_filter/sort_by.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/search_and_filter/sort_by_item.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/search_and_filter/sort_option.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/search_and_filter/sort_title.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductsViewModel extends MockCubit<ProductsStates> implements ProductsViewModel {}

void main() {
  late MockProductsViewModel mockProductsViewModel;

  setUp(() {
    mockProductsViewModel = MockProductsViewModel();
    when(() => mockProductsViewModel.state).thenReturn(ProductsStates());
    registerFallbackValue(FetchProductsEvent());
  });

  Widget createWidgetUnderTest(Widget child) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    );
  }

  group('SortBy Widget Tests', () {
    testWidgets('Initial State: renders title, options and action button', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(SortBy(mockProductsViewModel)));

      expect(find.byType(SortTitle), findsOneWidget);
      expect(find.byType(SortByItem), findsNWidgets(5));
      expect(find.byType(FilterActionButton), findsOneWidget);
    });

    testWidgets('Interaction: selecting an option and clicking filter triggers event', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(SortBy(mockProductsViewModel)));

      // Tap on "Highest Price" option
      await tester.tap(find.textContaining('High')); // Assuming localization has "Highest Price"
      await tester.pump();

      await tester.tap(find.byType(FilterActionButton));
      await tester.pump();

      verify(() => mockProductsViewModel.doIntent(any(that: isA<FetchProductsEvent>()))).called(1);
    });
  });

  group('SortByItem Widget Tests', () {
    testWidgets('Initial State: renders label and RadioListTile', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        const SortByItem(label: 'Test Label', option: SortOption.newest),
      ));

      expect(find.text('Test Label'), findsOneWidget);
      expect(find.byType(RadioListTile<SortOption>), findsOneWidget);
    });
  });

  group('FilterActionButton Widget Tests', () {
    testWidgets('Initial State: renders localized text and icon', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        FilterActionButton(onPressed: () {}),
      ));

      expect(find.byIcon(Icons.filter_list_outlined), findsOneWidget);
      final BuildContext context = tester.element(find.byType(FilterActionButton));
      expect(find.text(AppLocalizations.of(context)!.filter), findsOneWidget);
    });
  });
}
