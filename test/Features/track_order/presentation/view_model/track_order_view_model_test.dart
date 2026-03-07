import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/track_order/data/models/order_tracking_firebase_model.dart';
import 'package:flowers_app/Features/track_order/domain/entities/driver_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/order_tracking_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/tracking_location_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/user_location_entity.dart';
import 'package:flowers_app/Features/track_order/domain/use_cases/get_order_details_use_case.dart';
import 'package:flowers_app/Features/track_order/domain/use_cases/send_silent_notification_use_case.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_event.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_state.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_view_model.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockGetOrderDetailsUseCase extends Mock
    implements GetOrderDetailsUseCase {}

class MockSendSilentNotificationUseCase extends Mock
    implements SendSilentNotificationUseCase {}

class MockBuildContext extends Mock implements BuildContext {}

class StubOrderStatusViewModel extends OrderStatusViewModel {
  StubOrderStatusViewModel(
    super.getOrderDetailsUseCase,
    super.sendSilentNotificationUseCase,
  );

  final StreamController<OrderTrackingFirebaseModel> controller =
      StreamController<OrderTrackingFirebaseModel>.broadcast();

  @override
  Stream<OrderTrackingFirebaseModel> watchOrder(String orderId) {
    return controller.stream;
  }

  @override
  Future<void> close() {
    controller.close();
    return super.close();
  }
}

void main() {
  late StubOrderStatusViewModel viewModel;
  late MockGetOrderDetailsUseCase mockGetOrderDetailsUseCase;
  late MockSendSilentNotificationUseCase mockSendSilentNotificationUseCase;
  late MockBuildContext mockContext;
  const tOrderId = "order_123";

  setUpAll(() {
    registerFallbackValue(const TrackOrderStatusState());
    // No need for fallback for String as it's not a custom type usually, but anyway
  });

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    mockGetOrderDetailsUseCase = MockGetOrderDetailsUseCase();
    mockSendSilentNotificationUseCase = MockSendSilentNotificationUseCase();
    mockContext = MockBuildContext();
    viewModel = StubOrderStatusViewModel(
      mockGetOrderDetailsUseCase,
      mockSendSilentNotificationUseCase,
    );
  });

  tearDown(() {
    viewModel.close();
  });

  final tDateTime = DateTime(2023, 10, 10, 10, 00);

  final tOrderEntity = OrderTrackingEntity(
    id: tOrderId,
    orderNumber: "ORD-123",
    status: "accepted",
    updatedAt: tDateTime,
    totalPrice: 100,
    paymentType: "Cash",
    shippingAddress: "Cairo",
    trackingLocation: TrackingLocationEntity(lat: 5.0, long: 10.0),
    userLocationEntity: UserLocationEntity(lat: 6.0, long: 11.0),
    driver: DriverEntity(
      id: "1",
      name: "Nagham",
      phone: "0",
      token: "t",
      vehicleNumber: "v",
      vehicleImage: "i",
    ),
  );

  final tFirebaseModel = OrderTrackingFirebaseModel(
    userData: {},
    orderData: {},
    driverData: {},
    trackingLocation: {},
    storeData: {},
    orderItems: [],
    status: "on_the_way",
    updatedAt: tDateTime,
  );

  group('OrderStatusViewModel Detailed Coverage', () {
    test('Initial state should be correct', () {
      expect(viewModel.state, const TrackOrderStatusState());
    });

    blocTest<StubOrderStatusViewModel, TrackOrderStatusState>(
      'Success Flow: Emits loading, then success',
      build: () {
        when(
          () => mockGetOrderDetailsUseCase.call(any()),
        ).thenAnswer((_) async => tOrderEntity);
        return viewModel;
      },
      act: (bloc) =>
          bloc.doIntent(mockContext, FetchOrderDetailsEvent(tOrderId)),
      expect: () => [
        isA<TrackOrderStatusState>().having(
          (s) => s.orderState?.isLoading,
          'isLoading',
          true,
        ),
        isA<TrackOrderStatusState>().having(
          (s) => s.statusHistory.containsKey('accepted'),
          'hasHistory',
          true,
        ),
        isA<TrackOrderStatusState>().having(
          (s) => s.orderState?.data,
          'data',
          tOrderEntity,
        ),
      ],
    );

    blocTest<StubOrderStatusViewModel, TrackOrderStatusState>(
      'Emits error state when useCase returns null',
      build: () {
        when(
          () => mockGetOrderDetailsUseCase.call(any()),
        ).thenAnswer((_) async => null);
        return viewModel;
      },
      act: (bloc) =>
          bloc.doIntent(mockContext, FetchOrderDetailsEvent(tOrderId)),
      expect: () => [
        isA<TrackOrderStatusState>().having(
          (s) => s.orderState?.isLoading,
          'isLoading',
          true,
        ),
        isA<TrackOrderStatusState>().having(
          (s) => s.orderState?.errorMessage,
          'error',
          "Order Not Found",
        ),
      ],
    );

    blocTest<StubOrderStatusViewModel, TrackOrderStatusState>(
      'SendSilentNotificationEvent: Emits loading, then success',
      build: () {
        when(
          () => mockSendSilentNotificationUseCase.call(
            orderId: any(named: 'orderId'),
            driverToken: any(named: 'driverToken'),
          ),
        ).thenAnswer((_) async => SuccessResponse<bool>(data: true));
        return viewModel;
      },
      act: (bloc) => bloc.doIntent(
        mockContext,
        SendSilentNotificationEvent(orderId: tOrderId, driverToken: "t"),
      ),
      expect: () => [
        isA<TrackOrderStatusState>().having(
          (s) => s.sendSilentNotificationState?.isLoading,
          'isLoading',
          true,
        ),
        isA<TrackOrderStatusState>().having(
          (s) => s.sendSilentNotificationState?.data,
          'data',
          true,
        ),
      ],
    );

    blocTest<StubOrderStatusViewModel, TrackOrderStatusState>(
      'SendSilentNotificationEvent: Emits loading, then error',
      build: () {
        when(
          () => mockSendSilentNotificationUseCase.call(
            orderId: any(named: 'orderId'),
            driverToken: any(named: 'driverToken'),
          ),
        ).thenAnswer((_) async => ErrorResponse<bool>(errorMessage: "Error"));
        return viewModel;
      },
      act: (bloc) => bloc.doIntent(
        mockContext,
        SendSilentNotificationEvent(orderId: tOrderId, driverToken: "t"),
      ),
      expect: () => [
        isA<TrackOrderStatusState>().having(
          (s) => s.sendSilentNotificationState?.isLoading,
          'isLoading',
          true,
        ),
        isA<TrackOrderStatusState>().having(
          (s) => s.sendSilentNotificationState?.errorMessage,
          'error',
          "Error",
        ),
      ],
    );
  });
}
