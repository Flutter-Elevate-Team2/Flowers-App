import 'dart:async';

import 'package:flowers_app/Features/track_order/domain/entities/driver_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/order_tracking_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/tracking_location_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/user_location_entity.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_event.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_state.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_view_model.dart';
import 'package:flowers_app/Features/track_order/presentation/views/track_order_screen.dart';
import 'package:flowers_app/Features/track_order/presentation/widgets/driver_info.dart';
import 'package:flowers_app/Features/track_order/presentation/widgets/track_order_shimmer.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/di/di.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          builder: (context, state) =>
              const Scaffold(body: Center(child: Text('Home'))),
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

  group('TrackOrderBody Widget Tests', () {
    testWidgets('Should show TrackOrderShimmer when state is loading', (
      tester,
    ) async {
      // Arrange
      final loadingState = const TrackOrderStatusState(
        orderState: BaseState(isLoading: true),
      );

      when(() => mockViewModel.state).thenReturn(loadingState);
      when(
        () => mockViewModel.stream,
      ).thenAnswer((_) => Stream.value(loadingState));
      when(
        () => mockViewModel.doIntent(any(), any()),
      ).thenAnswer((_) async => {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(const Duration(milliseconds: 100));

      // Assert
      expect(find.byType(TrackOrderShimmer), findsOneWidget);
    });

    testWidgets('Should show error message when orderState has errorMessage', (
      tester,
    ) async {
      // Arrange
      const tError = "Connection Failed";
      final errorState = const TrackOrderStatusState(
        orderState: BaseState(errorMessage: tError),
      );

      when(() => mockViewModel.state).thenReturn(errorState);
      when(
        () => mockViewModel.stream,
      ).thenAnswer((_) => Stream.value(errorState));
      when(
        () => mockViewModel.doIntent(any(), any()),
      ).thenAnswer((_) async => {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Assert
      expect(find.text(tError), findsOneWidget);
    });

    testWidgets('Should display Order Details correctly on Success state', (
      tester,
    ) async {
      // Arrange
      final tOrder = OrderTrackingEntity(
        status: 'delivered',
        driver: DriverEntity(
          name: 'Ali',
          vehicleImage: '',
          id: '',
          phone: '',
          token: '',
          vehicleNumber: '',
        ),
        id: 'order_123',
        orderNumber: '#123',
        updatedAt: DateTime.now(),
        totalPrice: 11,
        paymentType: 'Cash',
        shippingAddress: 'Cairo',
        trackingLocation: TrackingLocationEntity(lat: 5.0, long: 10.5),
        userLocationEntity: UserLocationEntity(lat: 6.5, long: 11.0),
      );

      final successState = TrackOrderStatusState(
        orderState: BaseState(data: tOrder),
        statusHistory: {"on_the_way": DateTime.now()},
      );

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

        await tester.pump();
        await tester.pump(const Duration(seconds: 1));

        // Assert
        expect(find.byType(DriverInfo), findsOneWidget);
        expect(find.text("Ali"), findsOneWidget);
        expect(find.byIcon(Icons.call_outlined), findsOneWidget);
        expect(
          find.byWidgetPredicate(
            (w) => w is FaIcon && w.icon == FontAwesomeIcons.whatsapp,
          ),
          findsOneWidget,
        );
      });
    });
  });
}
