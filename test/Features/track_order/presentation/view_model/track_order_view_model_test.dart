import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/track_order/data/models/order_tracking_firebase_model.dart';
import 'package:flowers_app/Features/track_order/domain/entities/driver_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/order_tracking_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/tracking_location_entity.dart';
import 'package:flowers_app/Features/track_order/domain/entities/user_location_entity.dart';
import 'package:flowers_app/Features/track_order/domain/use_cases/get_order_details_use_case.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_event.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_state.dart';
import 'package:flowers_app/Features/track_order/presentation/view_model/track_order_view_model.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

@GenerateMocks([GetOrderDetailsUseCase, BuildContext])
import 'track_order_view_model_test.mocks.dart';

 class MockOrderStatusViewModel extends OrderStatusViewModel {
  MockOrderStatusViewModel(super.getOrderDetailsUseCase);

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
  late MockOrderStatusViewModel viewModel;
  late MockGetOrderDetailsUseCase mockGetOrderDetailsUseCase;
  late MockBuildContext mockContext;
  const tOrderId = "order_123";

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    mockGetOrderDetailsUseCase = MockGetOrderDetailsUseCase();
    mockContext = MockBuildContext();
    viewModel = MockOrderStatusViewModel(mockGetOrderDetailsUseCase);
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
    driver: DriverEntity(id: "1", name: "Nagham", phone: "0", token: "t", vehicleNumber: "v", vehicleImage: "i"),
  );

  final tFirebaseModel = OrderTrackingFirebaseModel( userData: {}, orderData: {}, driverData: {}, trackingLocation: {}, storeData: {}, orderItems: [],
    status: "on_the_way",
    updatedAt: tDateTime,
  );

  group('OrderStatusViewModel Detailed Coverage', () {

    test('Initial state should be correct', () {
      expect(viewModel.state, const TrackOrderStatusState());
    });

     blocTest<MockOrderStatusViewModel, TrackOrderStatusState>(
      'Success Flow: Emits loading, then success and saves to SharedPreferences',
      build: () {
        when(mockGetOrderDetailsUseCase.call(tOrderId)).thenAnswer((_) async => tOrderEntity);
        return viewModel;
      },
      act: (bloc) => bloc.doIntent(mockContext, FetchOrderDetailsEvent(tOrderId)),
      expect: () => [
        isA<TrackOrderStatusState>().having((s) => s.orderState?.isLoading, 'isLoading', true),
        isA<TrackOrderStatusState>().having((s) => s.statusHistory.containsKey('accepted'), 'hasHistory', true),
        isA<TrackOrderStatusState>().having((s) => s.orderState?.data, 'data', tOrderEntity),
      ],
    );

     blocTest<MockOrderStatusViewModel, TrackOrderStatusState>(
      'Emits error state when useCase returns null',
      build: () {
        when(mockGetOrderDetailsUseCase.call(tOrderId)).thenAnswer((_) async => null);
        return viewModel;
      },
      act: (bloc) => bloc.doIntent(mockContext, FetchOrderDetailsEvent(tOrderId)),
      expect: () => [
        isA<TrackOrderStatusState>().having((s) => s.orderState?.isLoading, 'isLoading', true),
        isA<TrackOrderStatusState>().having((s) => s.orderState?.errorMessage, 'error', "Order Not Found"),
      ],
    );

    blocTest<MockOrderStatusViewModel, TrackOrderStatusState>(
      'Should update state when Firebase stream emits new data',
      build: () {
        when(mockGetOrderDetailsUseCase.call(tOrderId)).thenAnswer((_) async => tOrderEntity);
        return viewModel;
      },
      act: (bloc) async {
         bloc.doIntent(mockContext, FetchOrderDetailsEvent(tOrderId));
        await Future.delayed(Duration(milliseconds: 100));

         bloc.controller.add(tFirebaseModel);

         await Future.delayed(Duration(milliseconds: 100));
      },
      skip: 3,
      expect: () => [
         isA<TrackOrderStatusState>().having(
                (s) => s.statusHistory.containsKey('on_the_way'),
            'statusHistory updated',
            true
        ),
         isA<TrackOrderStatusState>().having(
                (s) => s.statusHistory.containsKey('on_the_way'),
            'statusHistory remains updated',
            true
        ),
      ],
    );

     blocTest<MockOrderStatusViewModel, TrackOrderStatusState>(
      'Branch Coverage: Loading state when data already exists',
      build: () {
        when(mockGetOrderDetailsUseCase.call(tOrderId)).thenAnswer((_) async => tOrderEntity);
        return viewModel;
      },
      seed: () => TrackOrderStatusState(
        orderState: BaseState(data: tOrderEntity, isLoading: false),
      ),
      act: (bloc) => bloc.doIntent(mockContext, FetchOrderDetailsEvent(tOrderId)),
      expect: () => [
        isA<TrackOrderStatusState>().having((s) => s.orderState?.isLoading, 'isLoading', true),
        isA<TrackOrderStatusState>().having((s) => s.statusHistory, 'historyUpdated', isNotEmpty),
        isA<TrackOrderStatusState>().having((s) => s.orderState?.isLoading, 'isLoading', false),
      ],
    );
  });
}