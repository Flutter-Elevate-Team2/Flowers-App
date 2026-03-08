import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/commerce/domain/entities/home_entities/category_entity.dart';
import 'package:flowers_app/Features/commerce/presentation/products/view_model/products_events.dart';
import 'package:flowers_app/Features/commerce/presentation/products/view_model/products_states.dart';
import 'package:flowers_app/Features/commerce/presentation/products/view_model/products_view_model.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/categories/categories_page.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/categories/category_body.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/default_tab_bar.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/paginated_products_view.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_states.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_view_model.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductsViewModel extends MockCubit<ProductsStates>
    implements ProductsViewModel {}

class MockCartViewModel extends MockCubit<CartStates>
    implements CartViewModel {}

void main() {
  late MockProductsViewModel mockProductsViewModel;
  late MockCartViewModel mockCartViewModel;
  late List<CategoryEntity> testCategories;

  setUp(() {
    mockProductsViewModel = MockProductsViewModel();
    mockCartViewModel = MockCartViewModel();
    testCategories = [
      CategoryEntity(id: '1', name: 'Flowers', icon: 'img1'),
      CategoryEntity(id: '2', name: 'Plants', icon: 'img2'),
    ];

    when(() => mockProductsViewModel.state).thenReturn(ProductsStates());
    when(() => mockCartViewModel.state).thenReturn(const CartStates());

    registerFallbackValue(LoadMoreProductsEvent());
    registerFallbackValue(FetchProductsEvent());
  });

  Widget createWidgetUnderTest(Widget child) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider<ProductsViewModel>.value(value: mockProductsViewModel),
            BlocProvider<CartViewModel>.value(value: mockCartViewModel),
          ],
          child: child,
        ),
      ),
    );
  }

  group('CategoriesPage Widget Tests', () {
    testWidgets('Initial State: renders correctly with categories', (
      tester,
    ) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          CategoriesPage(categories: testCategories, initialIndex: 0),
        ),
      );

      expect(find.byType(CategoryBody), findsOneWidget);
      expect(find.text('Flowers'), findsWidgets);
    });

    testWidgets(
      'Loading State: renders loading tab bar when categories are null',
      (tester) async {
        await tester.pumpWidget(
          createWidgetUnderTest(
            const CategoriesPage(categories: null, initialIndex: 0),
          ),
        );

        final tabBarFinder = find.byType(DefaultTabBar);
        expect(tabBarFinder, findsOneWidget);

        final DefaultTabBar tabBar = tester.widget(tabBarFinder);
        expect(tabBar.isLoading, isTrue);
      },
    );
  });

  group('CategoryBody Widget Tests', () {
    Widget buildCategoryBody() {
      return DefaultTabController(
        length: 3,
        child: CategoryBody(
          searchController: TextEditingController(),
          tabs: const ['All', 'Flowers', 'Plants'],
          scrollController: ScrollController(),
          categories: testCategories,
        ),
      );
    }

    testWidgets(
      'Initial State: renders SearchAndFilterBar and PaginatedProductsView',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest(buildCategoryBody()));

        expect(find.byType(PaginatedProductsView), findsOneWidget);
        expect(find.byType(TextField), findsOneWidget);
      },
    );

    testWidgets(
      'Interaction: triggers FetchProductsEvent when a tab is tapped',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 1920);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(createWidgetUnderTest(buildCategoryBody()));

        await tester.tap(find.text('All').first);
        await tester.pumpAndSettle();

        verify(
          () => mockProductsViewModel.doIntent(
            any(that: isA<FetchProductsEvent>()),
          ),
        ).called(1);
      },
    );
  });
}
