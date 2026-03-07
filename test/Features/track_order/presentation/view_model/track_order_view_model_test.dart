import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/track_order/data/models/order_tracking_firebase_model.dart';
import 'package:flowers_app/Features/track_order/domain/entities/driver_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/order_tracking_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/store_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/tracking_location_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/user_location_entity.dart';
import 'package:flowers_app/Features/track_order/domain/use_cases/get_directions_use_case.dart';
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
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapbox;

class MockGetOrderDetailsUseCase extends Mock
    implements GetOrderDetailsUseCase {}

class MockSendSilentNotificationUseCase extends Mock
    implements SendSilentNotificationUseCase {}

class MockGetDirectionsUseCase extends Mock implements GetDirectionsUseCase {}

class MockBuildContext extends Mock implements BuildContext {}

class StubOrderStatusViewModel extends OrderStatusViewModel {
  StubOrderStatusViewModel(
    super.getOrderDetailsUseCase,
    super.sendSilentNotificationUseCase,
    super.getDirectionsUseCase,
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
  late MockGetDirectionsUseCase mockGetDirectionsUseCase;
  late MockBuildContext mockContext;

  const tOrderId = "order_123";
  final tDateTime = DateTime(2026, 1, 1);

  setUpAll(() {
    registerFallbackValue(const TrackOrderStatusState());
    registerFallbackValue(<mapbox.Position>[]);
  });

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    mockGetOrderDetailsUseCase = MockGetOrderDetailsUseCase();
    mockSendSilentNotificationUseCase = MockSendSilentNotificationUseCase();
    mockGetDirectionsUseCase = MockGetDirectionsUseCase();
    mockContext = MockBuildContext();

    when(
      () => mockGetDirectionsUseCase.call(any()),
    ).thenAnswer((_) async => <mapbox.Position>[]);

    viewModel = StubOrderStatusViewModel(
      mockGetOrderDetailsUseCase,
      mockSendSilentNotificationUseCase,
      mockGetDirectionsUseCase,
    );
  });

  tearDown(() {
    viewModel.close();
  });

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
    store: StoreEntity(storeLat: 7.0, storeLong: 12.5),
  );

  final tFirebaseModel = OrderTrackingFirebaseModel(
    userData: {},
    orderData: {'status': 'on_the_way', 'id': tOrderId},
    driverData: {'token': 'token_123'},
    trackingLocation: {'lat': 5.1, 'long': 10.1},
    storeData: {'lat': 7.0, 'long': 12.5},
    orderItems: [],
    status: "on_the_way",
    updatedAt: tDateTime,
  );

  group('OrderStatusViewModel Integrated Tests', () {
    test('Initial state should be correct', () {
      expect(viewModel.state, const TrackOrderStatusState());
    });

    blocTest<StubOrderStatusViewModel, TrackOrderStatusState>(
      'FetchOrderDetails Success: Emits Loading -> HistoryUpdated -> Success',
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
          'loading',
          true,
        ),
        isA<TrackOrderStatusState>().having(
          (s) => s.statusHistory.containsKey('accepted'),
          'history',
          true,
        ),
        isA<TrackOrderStatusState>()
            .having((s) => s.orderState?.isLoading, 'success', false)
            .having((s) => s.orderState?.data?.id, 'id', tOrderId),
      ],
    );

    blocTest<StubOrderStatusViewModel, TrackOrderStatusState>(
      'Firebase Stream: Emits updated route and history when driver moves',
      build: () {
        when(
          () => mockGetOrderDetailsUseCase.call(any()),
        ).thenAnswer((_) async => tOrderEntity);
        when(
          () => mockGetDirectionsUseCase.call(any()),
        ).thenAnswer((_) async => [mapbox.Position(1.0, 1.0)]);
        return viewModel;
      },
      act: (bloc) async {
        await bloc.doIntent(mockContext, FetchOrderDetailsEvent(tOrderId));
        bloc.controller.add(tFirebaseModel);
        await Future.delayed(const Duration(milliseconds: 600));
      },
      skip: 3,
      expect: () => [
        isA<TrackOrderStatusState>()
            .having(
              (s) => s.statusHistory.containsKey('on_the_way'),
              'history update',
              true,
            )
            .having(
              (s) => s.routePoints,
              'route points initially null',
              isNull,
            ),

        isA<TrackOrderStatusState>()
            .having((s) => s.routePoints, 'route points updated', isNotNull)
            .having(
              (s) => s.routePoints,
              'route points not empty',
              (List? p) => p?.isNotEmpty ?? false,
            ),
      ],
      wait: const Duration(milliseconds: 600),
    );

    blocTest<StubOrderStatusViewModel, TrackOrderStatusState>(
      'SendSilentNotification Success',
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
          'loading',
          true,
        ),
        isA<TrackOrderStatusState>().having(
          (s) => s.sendSilentNotificationState?.data,
          'success',
          true,
        ),
      ],
    );
  });
}
