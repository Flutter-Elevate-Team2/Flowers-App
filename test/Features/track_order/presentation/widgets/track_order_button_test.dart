import 'dart:async';

import 'package:flowers_app/Features/track_order/domain/entities/driver_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/order_tracking_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/tracking_location_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/user_location_entity.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_event.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_state.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_view_model.dart';
import 'package:flowers_app/Features/track_order/presentation/widgets/track_order_button.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOrderStatusViewModel extends Mock implements OrderStatusViewModel {}

class FakeBuildContext extends Fake implements BuildContext {}

void main() {
  late MockOrderStatusViewModel mockViewModel;

  setUpAll(() {
    registerFallbackValue(FakeBuildContext());
    registerFallbackValue(const TrackOrderStatusState());
    registerFallbackValue(FetchOrderDetailsEvent(""));
  });

  setUp(() {
    mockViewModel = MockOrderStatusViewModel();
    when(() => mockViewModel.close()).thenAnswer((_) async => {});
    when(
      () => mockViewModel.doIntent(any(), any()),
    ).thenAnswer((_) async => {});
    when(() => mockViewModel.state).thenReturn(const TrackOrderStatusState());
    when(
      () => mockViewModel.stream,
    ).thenAnswer((_) => Stream.value(const TrackOrderStatusState()));
  });

  Widget createWidget({
    required bool isDelivered,
    TrackOrderStatusState state = const TrackOrderStatusState(),
    Stream<TrackOrderStatusState>? stream,
  }) {
    when(() => mockViewModel.state).thenReturn(state);
    when(
      () => mockViewModel.stream,
    ).thenAnswer((_) => stream ?? Stream.value(state));

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: BlocProvider<OrderStatusViewModel>.value(
          value: mockViewModel,
          child: TrackOrderButton(isDelivered: isDelivered),
        ),
      ),
    );
  }

  group('TrackOrderButton Widget Test - Detailed', () {
    testWidgets('shows single "Show map" button when isDelivered is false', (
      tester,
    ) async {
      await tester.pumpWidget(createWidget(isDelivered: false));

      expect(find.text('Show map'), findsOneWidget);
    });

    testWidgets('shows two buttons when isDelivered is true and not loading', (
      tester,
    ) async {
      final state = TrackOrderStatusState(
        sendSilentNotificationState: const BaseState(isLoading: false),
      );

      await tester.pumpWidget(createWidget(isDelivered: true, state: state));

      expect(find.text('Show map'), findsOneWidget);
      expect(find.text('Order Delivered'), findsOneWidget);
    });

    testWidgets(
      'shows loading indicator when sendSilentNotificationState is loading',
      (tester) async {
        final state = TrackOrderStatusState(
          sendSilentNotificationState: const BaseState(isLoading: true),
        );

        await tester.pumpWidget(createWidget(isDelivered: true, state: state));

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'triggers SendSilentNotificationEvent when "Order Delivered" is pressed',
      (tester) async {
        final tOrder = OrderTrackingEntity(
          id: "order_123",
          driver: DriverEntity(
            id: "1",
            name: "Nagham",
            phone: "0",
            token: "driver_token",
            vehicleNumber: "v",
            vehicleImage: "i",
          ),
          orderNumber: "ORD-123",
          status: "delivered",
          updatedAt: DateTime.now(),
          totalPrice: 100,
          paymentType: "Cash",
          shippingAddress: "Cairo",
          trackingLocation: TrackingLocationEntity(lat: 0, long: 0),
          userLocationEntity: UserLocationEntity(lat: 0, long: 0),
        );

        final state = TrackOrderStatusState(
          orderState: BaseState(data: tOrder),
          sendSilentNotificationState: const BaseState(isLoading: false),
        );

        await tester.pumpWidget(createWidget(isDelivered: true, state: state));

        await tester.tap(find.text('Order Delivered'));
        await tester.pump();

        verify(
          () => mockViewModel.doIntent(
            any(),
            any(that: isA<SendSilentNotificationEvent>()),
          ),
        ).called(1);
      },
    );

    testWidgets('shows success snackbar when notification sent successfully', (
      tester,
    ) async {
      final controller = StreamController<TrackOrderStatusState>.broadcast();

      await tester.pumpWidget(
        createWidget(
          isDelivered: true,
          state: const TrackOrderStatusState(),
          stream: controller.stream,
        ),
      );

      controller.add(
        const TrackOrderStatusState(
          sendSilentNotificationState: BaseState(isLoading: false, data: true),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);

      await controller.close();
    });
  });
}
