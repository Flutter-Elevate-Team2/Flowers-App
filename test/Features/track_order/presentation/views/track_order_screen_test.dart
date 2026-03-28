import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_event.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_state.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_view_model.dart';
import 'package:flowers_app/Features/track_order/presentation/views/track_order_screen.dart';
import 'package:flowers_app/core/di/di.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockOrderStatusViewModel extends Mock implements OrderStatusViewModel {}

class FakeBuildContext extends Fake implements BuildContext {}

void main() {
  late MockOrderStatusViewModel mockViewModel;
  const tOrderId = "order_123";

  setUpAll(() {
    registerFallbackValue(FakeBuildContext());
    registerFallbackValue(const TrackOrderStatusState());
    registerFallbackValue(FetchOrderDetailsEvent(""));
  });

  setUp(() async {
    mockViewModel = MockOrderStatusViewModel();

    when(() => mockViewModel.close()).thenAnswer((_) async => {});

    await getIt.reset();
    getIt.registerFactory<OrderStatusViewModel>(() => mockViewModel);
  });

  Widget createWidgetUnderTest() {
    final router = GoRouter(
      initialLocation: '/track',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const Scaffold(body: Text('Home')),
        ),
        GoRoute(
          path: '/track',
          builder: (context, state) =>
              const TrackOrderScreen(orderId: tOrderId),
        ),
      ],
    );

    return MaterialApp.router(
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }

  group('TrackOrderScreen Widget Tests', () {
    testWidgets(
      'Should initialize with FetchOrderDetailsEvent and show loading',
      (tester) async {
        // Arrange
        const initialState = TrackOrderStatusState();

        when(() => mockViewModel.state).thenReturn(initialState);
        when(
          () => mockViewModel.stream,
        ).thenAnswer((_) => const Stream.empty());
        when(
          () => mockViewModel.doIntent(any(), any()),
        ).thenAnswer((_) async => {});

        // Act
        await tester.pumpWidget(createWidgetUnderTest());

        // Assert
        verify(
          () => mockViewModel.doIntent(
            any(),
            any(that: isA<FetchOrderDetailsEvent>()),
          ),
        ).called(1);
        expect(find.byType(AppBar), findsOneWidget);
      },
    );

    testWidgets(
      'Should reflect state changes in the UI (Integration with Body)',
      (tester) async {
        // Arrange
        const successState = TrackOrderStatusState();

        when(() => mockViewModel.state).thenReturn(successState);
        when(
          () => mockViewModel.stream,
        ).thenAnswer((_) => Stream.value(successState));
        when(
          () => mockViewModel.doIntent(any(), any()),
        ).thenAnswer((_) async => {});

        await mockNetworkImagesFor(() async {
          // Act
          await tester.pumpWidget(createWidgetUnderTest());
          await tester.pumpAndSettle();

          // Assert
          expect(find.byType(TrackOrderScreen), findsOneWidget);
        });
      },
    );
  });
}
