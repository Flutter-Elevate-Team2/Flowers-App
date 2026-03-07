import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/track_order/data/mapper/order_tracking_mapper.dart';
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
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart' as mockito;
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'order_tracking_mapper_test.mocks.dart';

@GenerateMocks([
  GetOrderDetailsUseCase,
  SendSilentNotificationUseCase,
  BuildContext,
])
void main() {
  late OrderStatusViewModel viewModel;
  late MockGetOrderDetailsUseCase mockGetOrderDetailsUseCase;
  late MockSendSilentNotificationUseCase mockSendSilentNotificationUseCase;
  late MockBuildContext mockContext;
  const tOrderId = "order_123";

  setUpAll(() {
    mockito.provideDummy<OrderTrackingEntity?>(null);
  });

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    mockGetOrderDetailsUseCase = MockGetOrderDetailsUseCase();
    mockSendSilentNotificationUseCase = MockSendSilentNotificationUseCase();
    mockContext = MockBuildContext();
    viewModel = OrderStatusViewModel(
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
      id: "driver_001",
      name: "Nagham",
      phone: "0123456",
      token: "token_abc",
      vehicleNumber: "V-123",
      vehicleImage: "img.png",
    ),
  );

  group('OrderStatusViewModel Coverage Tests', () {
    test('initial state check', () {
      expect(viewModel.state.orderState?.isLoading, isFalse);
    });

    blocTest<OrderStatusViewModel, TrackOrderStatusState>(
      'emits [loading, success] when fetching details works',
      build: () {
        when(
          mockGetOrderDetailsUseCase.call(tOrderId),
        ).thenAnswer((_) async => tOrderEntity);
        return viewModel;
      },
      act: (bloc) =>
          bloc.doIntent(mockContext, FetchOrderDetailsEvent(tOrderId)),
      skip: 2,
      expect: () => [
        isA<TrackOrderStatusState>().having(
          (s) => s.orderState?.data,
          'data',
          tOrderEntity,
        ),
        isA<TrackOrderStatusState>().having(
          (s) => s.orderState?.errorMessage,
          'firebase_fail',
          contains('No Firebase App'),
        ),
      ],
    );

    blocTest<OrderStatusViewModel, TrackOrderStatusState>(
      'emits error state when usecase throws exception',
      build: () {
        when(
          mockGetOrderDetailsUseCase.call(any),
        ).thenThrow(Exception("Server Error"));
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
          (s) => s.orderState?.errorMessage,
          'error',
          contains("Server Error"),
        ),
      ],
    );

    blocTest<OrderStatusViewModel, TrackOrderStatusState>(
      'should handle loading correctly when data already exists',
      build: () {
        when(
          mockGetOrderDetailsUseCase.call(tOrderId),
        ).thenAnswer((_) async => tOrderEntity);
        return viewModel;
      },
      seed: () =>
          TrackOrderStatusState(orderState: BaseState(data: tOrderEntity)),
      act: (bloc) =>
          bloc.doIntent(mockContext, FetchOrderDetailsEvent(tOrderId)),
      expect: () => [
        isA<TrackOrderStatusState>().having(
          (s) => s.orderState?.isLoading,
          'loading',
          true,
        ),
        isA<TrackOrderStatusState>().having(
          (s) => s.statusHistory,
          'history',
          isNotEmpty,
        ),
        isA<TrackOrderStatusState>().having(
          (s) => s.orderState?.isLoading,
          'loading',
          false,
        ),
        isA<TrackOrderStatusState>().having(
          (s) => s.orderState?.errorMessage,
          'firebase_fail',
          isNotNull,
        ),
      ],
    );

    test('getStatusHistory and _saveStatus coverage', () async {
      await viewModel.getStatusHistory(tOrderId);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.containsKey("order_status_$tOrderId"), isFalse);
    });

    test('close cancels subscription', () async {
      await viewModel.close();
      expect(viewModel.isClosed, isTrue);
    });
  });

  group('OrderTrackingMapper Coverage Tests', () {
    test(
      'should map Firebase model to Entity correctly including Driver data',
      () {
        // Arrange
        final firebaseModel = OrderTrackingFirebaseModel(
          status: "on_way",
          updatedAt: tDateTime,
          orderData: {
            'orderId': '123',
            'orderNumber': 'ORD-123',
            'totalPrice': 150.5,
            'paymentType': 'Online',
            'shippingAddress': {
              'street': '9th Street',
              'city': 'Maadi',
              'location': {'lat': 30.0, 'long': 31.0},
            },
          },
          driverData: {
            'driverId': 'D-99',
            'driverName': 'Ahmed',
            'driverPhone': '0100',
            'driverToken': 'tok_1',
            'vehicleNumber': 'ABC-123',
            'vehicleImage': 'car.jpg',
          },
          trackingLocation: {'lat': 30.1, 'long': 31.1},
          userData: {},
          storeData: {},
          orderItems: [],
        );

        // Act
        final entity = firebaseModel.toEntity();

        // Assert
        expect(entity.id, '123');
        expect(entity.driver?.id, 'D-99');
        expect(entity.driver?.name, 'Ahmed');
        expect(entity.driver?.vehicleNumber, 'ABC-123');
        expect(entity.shippingAddress, '9th Street, Maadi');
        expect(entity.userLocationEntity.lat, 30.0);
      },
    );

    test('should handle missing driver data with default values in mapper', () {
      // Arrange
      final firebaseModel = OrderTrackingFirebaseModel(
        status: "pending",
        updatedAt: tDateTime,
        orderData: {},
        driverData: {},
        trackingLocation: {},
        userData: {},
        storeData: {},
        orderItems: [],
      );

      // Act
      final entity = firebaseModel.toEntity();

      // Assert
      expect(entity.driver?.id, '');
      expect(entity.driver?.name, '');
      expect(entity.driver?.vehicleNumber, '');
    });

    test('DriverEntity factory and toMap coverage', () {
      final map = {
        'driverId': 'D1',
        'driverName': 'Test',
        'driverPhone': '123',
        'driverToken': 'T1',
        'vehicleNumber': 'V1',
        'vehicleImage': 'I1',
      };

      final driver = DriverEntity.fromMap(map);
      final generatedMap = driver.toMap();

      expect(driver.id, 'D1');
      expect(generatedMap['driverId'], 'D1');
    });
  });
}
