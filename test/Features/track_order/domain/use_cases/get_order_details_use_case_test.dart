import 'package:flowers_app/Features/track_order/data/models/order_tracking_firebase_model.dart';
import 'package:flowers_app/Features/track_order/domain/entities/order_tracking_entity.dart';
import 'package:flowers_app/Features/track_order/domain/use_cases/get_order_details_use_case.dart';
import 'package:flowers_app/core/services/firebase_data_uploader_service.dart';
 import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

 @GenerateMocks([FirebaseDataUploaderService])
import 'get_order_details_use_case_test.mocks.dart';

void main() {
  late GetOrderDetailsUseCase useCase;
  late MockFirebaseDataUploaderService mockFirebaseService;

  setUp(() {
    mockFirebaseService = MockFirebaseDataUploaderService();
    useCase = GetOrderDetailsUseCase(mockFirebaseService);
  });

  const tOrderId = 'order_123';

   final tFirebaseModel = OrderTrackingFirebaseModel(
    orderData: {'orderId': tOrderId, 'orderNumber': 'ORD-123'},
    userData: {},
    driverData: {},
    trackingLocation: {},
    storeData: {},
    orderItems: [],
    status: 'accepted',
    updatedAt: DateTime.now(),
  );

  test('should return OrderTrackingEntity when firebase service returns a model', () async {
    // Arrange
    when(mockFirebaseService.getTrackingOrderById(tOrderId))
        .thenAnswer((_) async => tFirebaseModel);

    // Act
    final result = await useCase.call(tOrderId);

    // Assert
    expect(result, isA<OrderTrackingEntity>());
    expect(result?.id, tOrderId);
    verify(mockFirebaseService.getTrackingOrderById(tOrderId)).called(1);
    verifyNoMoreInteractions(mockFirebaseService);
  });

  test('should return null when firebase service returns null', () async {
    // Arrange
    when(mockFirebaseService.getTrackingOrderById(tOrderId))
        .thenAnswer((_) async => null);

    // Act
    final result = await useCase.call(tOrderId);

    // Assert
    expect(result, isNull);
    verify(mockFirebaseService.getTrackingOrderById(tOrderId)).called(1);
  });

  test('should throw an exception if firebase service throws', () async {
    // Arrange
    when(mockFirebaseService.getTrackingOrderById(tOrderId))
        .thenThrow(Exception('Firebase Error'));

    // Act & Assert
    expect(() => useCase.call(tOrderId), throwsA(isA<Exception>()));
  });
}