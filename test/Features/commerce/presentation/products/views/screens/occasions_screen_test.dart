import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/commerce/domain/entities/home_entities/occasion_entity.dart';
import 'package:flowers_app/Features/commerce/presentation/products/view_model/products_events.dart';
import 'package:flowers_app/Features/commerce/presentation/products/view_model/products_states.dart';
import 'package:flowers_app/Features/commerce/presentation/products/view_model/products_view_model.dart';
import 'package:flowers_app/Features/commerce/presentation/products/views/screens/occasions_screen.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/occasions/occasion_page.dart';
import 'package:flowers_app/core/di/di.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockProductsViewModel extends MockCubit<ProductsStates>
    implements ProductsViewModel {}

void main() {
  late MockProductsViewModel mockProductsViewModel;
  late List<OccasionEntity> testOccasions;

  setUpAll(() {
    registerFallbackValue(FetchProductsEvent());
    registerFallbackValue(FetchOccasionsEvent());
  });

  setUp(() async {
    mockProductsViewModel = MockProductsViewModel();
    testOccasions = [
      OccasionEntity(id: '1', name: 'Birthday', imageUrl: 'img1'),
      OccasionEntity(id: '2', name: 'Wedding', imageUrl: 'img2'),
    ];

    when(() => mockProductsViewModel.state).thenReturn(ProductsStates());

    await getIt.reset();
    getIt.registerFactory<ProductsViewModel>(() => mockProductsViewModel);
  });

  Widget createWidgetUnderTest(Widget child) {
    final router = GoRouter(
      routes: [GoRoute(path: '/', builder: (context, state) => child)],
    );

    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }

  group('OccasionsScreen Tests', () {
    testWidgets('triggers FetchProductsEvent on creation with initialIndex', (
      tester,
    ) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          OccasionsScreen(occasions: testOccasions, initialIndex: 1),
        ),
      );

      verify(
        () => mockProductsViewModel.doIntent(
          any(
            that: isA<FetchProductsEvent>().having(
              (e) => e.occasionId,
              'id',
              '2',
            ),
          ),
        ),
      ).called(1);
    });

    testWidgets('triggers FetchOccasionsEvent when occasions list is null', (
      tester,
    ) async {
      await tester.pumpWidget(
        createWidgetUnderTest(const OccasionsScreen(occasions: null)),
      );

      verify(
        () => mockProductsViewModel.doIntent(
          any(that: isA<FetchOccasionsEvent>()),
        ),
      ).called(1);
    });

    testWidgets('renders OccasionPage with provided occasions', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          OccasionsScreen(occasions: testOccasions, initialIndex: 0),
        ),
      );

      expect(find.byType(OccasionPage), findsOneWidget);
      expect(find.text('Birthday'), findsWidgets);
    });
  });
}
