import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/commerce/presentation/products/view_model/products_states.dart';
import 'package:flowers_app/Features/commerce/presentation/products/view_model/products_view_model.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/search_and_filter/sort_by.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/floating_button.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/floating_button_content.dart';
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
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        floatingActionButton: FloatingButton(mockProductsViewModel),
      ),
    );
  }

  group('FloatingButton Widget Tests', () {
    testWidgets('Initial State: renders FloatingActionButton with content', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byType(FloatingButtonContent), findsOneWidget);
    });

    testWidgets('Interaction: shows SortBy bottom sheet when pressed', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.byType(SortBy), findsOneWidget);
    });
  });
}
