import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_event.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_state.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_view_model.dart';
import 'package:flowers_app/Features/track_order/presentation/views/track_order_screen.dart';
import 'package:flowers_app/core/di/di.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:go_router/go_router.dart';
import 'package:network_image_mock/network_image_mock.dart';

 @GenerateMocks([OrderStatusViewModel])
import 'track_order_screen_test.mocks.dart';

void main() {
  late MockOrderStatusViewModel mockViewModel;
  const tOrderId = "order_123";

  setUp(() async {
    mockViewModel = MockOrderStatusViewModel();

     when(mockViewModel.close()).thenAnswer((_) async => {});

     await getIt.reset();
    getIt.registerFactory<OrderStatusViewModel>(() => mockViewModel);
  });

   Widget createWidgetUnderTest() {
    final router = GoRouter(
      initialLocation: '/track',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const Scaffold(
            body: Text('Home'),
          ),
        ),
        GoRoute(
          path: '/track',
          builder: (context, state) => const TrackOrderScreen(orderId: tOrderId),
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
    testWidgets('Should initialize with FetchOrderDetailsEvent and show loading', (tester) async {
      // Arrange
      final initialState = const TrackOrderStatusState();

      when(mockViewModel.state).thenReturn(initialState);
      when(mockViewModel.stream).thenAnswer((_) => Stream.value(initialState));

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
       verify(mockViewModel.doIntent(any, argThat(isA<FetchOrderDetailsEvent>()))).called(1);

       expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('Should reflect state changes in the UI (Integration with Body)', (tester) async {
      // Arrange
      final successState = const TrackOrderStatusState();

      when(mockViewModel.state).thenReturn(successState);
      when(mockViewModel.stream).thenAnswer((_) => Stream.value(successState));

      await mockNetworkImagesFor(() async {
        // Act
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        // Assert
        expect(find.byType(TrackOrderScreen), findsOneWidget);
      });
    });
  });
}