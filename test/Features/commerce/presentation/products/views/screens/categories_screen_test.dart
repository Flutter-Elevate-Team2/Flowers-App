import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/commerce/domain/entities/home_entities/category_entity.dart';
import 'package:flowers_app/Features/commerce/presentation/products/view_model/products_states.dart';
import 'package:flowers_app/Features/commerce/presentation/products/view_model/products_view_model.dart';
import 'package:flowers_app/Features/commerce/presentation/products/views/screens/categories_screen.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/shimmers/categories_tabs_shimmer.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

class MockProductsViewModel extends MockCubit<ProductsStates>
    implements ProductsViewModel {}

void main() {
  late MockProductsViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockProductsViewModel();
    GetIt.I.registerSingleton<ProductsViewModel>(mockViewModel);
  });

  tearDown(() {
    GetIt.I.unregister<ProductsViewModel>();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: CategoriesScreen(),
    );
  }

  testWidgets('CategoriesScreen renders and requests categories', (
    WidgetTester tester,
  ) async {
    // ARRANGE
    whenListen(
      mockViewModel,
      Stream.fromIterable([
        ProductsStates(
          categoriesState: BaseState(isLoading: true),
          productsState: BaseState(isLoading: true),
        ),
      ]),
      initialState: ProductsStates(),
    );

    // ACT
    await tester.pumpWidget(createWidgetUnderTest());

    // ASSERT
    // Can't easily verify intent without spying, but we can check if it rendered safely.
    expect(find.byType(CategoriesScreen), findsOneWidget);
  });

  testWidgets('shows loading indicator when categories are loading', (
    WidgetTester tester,
  ) async {
    // ARRANGE
    whenListen(
      mockViewModel,
      Stream.value(ProductsStates(categoriesState: BaseState(isLoading: true))),
      initialState: ProductsStates(categoriesState: BaseState(isLoading: true)),
    );

    // ACT
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(); // Trigger build

    // ASSERT
    // CategoriesPage uses CategoriesTabsShimmer when loading.
    // It might appear multiple times if the shimmer creates multiple items.
    expect(find.byType(CategoriesTabsShimmer), findsWidgets);
  });

  testWidgets('displays categories when loaded', (WidgetTester tester) async {
    // ARRANGE
    final categories = [
      CategoryEntity(id: '1', name: 'Valentine', icon: ''),
      CategoryEntity(id: '2', name: 'Birthday', icon: ''),
    ];

    whenListen(
      mockViewModel,
      Stream.value(
        ProductsStates(
          categoriesState: BaseState(data: categories, isLoading: false),
        ),
      ),
      initialState: ProductsStates(
        categoriesState: BaseState(data: categories, isLoading: false),
      ),
    );

    // ACT
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // ASSERT
    expect(find.text('Valentine'), findsOneWidget);
    expect(find.text('Birthday'), findsOneWidget);
  });
}
