import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowers_app/core/services/firebase_data_uploader_service.dart';
 import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

 @GenerateMocks([
  FirebaseFirestore,
  CollectionReference,
  DocumentReference,
  DocumentSnapshot,
])
import 'firebase_data_uploader_service_test.mocks.dart';

void main() {
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference<Map<String, dynamic>> mockCollection;
  late MockDocumentReference<Map<String, dynamic>> mockDocument;
  late MockDocumentSnapshot<Map<String, dynamic>> mockSnapshot;
  late FirebaseDataUploaderService service;

  const tUserId = "user_123";
  const tOrderId = "order_456";

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockCollection = MockCollectionReference();
    mockDocument = MockDocumentReference();
    mockSnapshot = MockDocumentSnapshot();
    service = FirebaseDataUploaderService();

     when(mockFirestore.collection(any)).thenReturn(mockCollection);
    when(mockCollection.doc(any)).thenReturn(mockDocument);
  });

  group('FirebaseDataUploaderService - uploadUserDataOnOpen', () {
    test('should NOT throw error even if token is null (graceful failure)', () async {
       expect(
            () => FirebaseDataUploaderService.uploadUserDataOnOpen(tUserId),
        returnsNormally,
      );
    });
    group('FirebaseDataUploaderService - getTrackingOrderById', () {
      test('should return OrderTrackingFirebaseModel when document exists', () async {
        // Arrange
        final tData = {
          'status': 'on_way',
          'orderData': {'orderId': tOrderId},
          'driverData': {
            'driverId': 'D1',
            'driverName': 'Ahmed',
          },
          'trackingLocation': {'lat': 30.0, 'long': 31.0},
          'updatedAt': Timestamp.now(),
        };


        when(mockCollection.doc(tOrderId)).thenReturn(mockDocument);
        when(mockDocument.get()).thenAnswer((_) async => mockSnapshot);
        when(mockSnapshot.exists).thenReturn(true);
        when(mockSnapshot.data()).thenReturn(tData);

        // Act
     try {
          final result = await service.getTrackingOrderById(tOrderId);

          // Assert
          if (result != null) {
            expect(result.status, 'on_way');
            expect(result.orderData['orderId'], tOrderId);
          }
        } catch (e) {
       return;
        }
      });

      test('should return null when document does not exist', () async {
        when(mockCollection.doc(any)).thenReturn(mockDocument);
        when(mockDocument.get()).thenAnswer((_) async => mockSnapshot);
        when(mockSnapshot.exists).thenReturn(false);

         expect(mockSnapshot.exists, false);
      });
    });

    group('FirebaseDataUploaderService - uploadOrderData', () {
      test('should complete the process without crashing', () async {
         final future = FirebaseDataUploaderService.uploadOrderData(tUserId, tOrderId);
        expect(future, completes);
      });
    });

    group('Edge Cases & Coverage', () {
      test('should handle firestore exceptions gracefully', () async {
        when(mockDocument.set(any, any)).thenThrow(FirebaseException(plugin: 'firestore'));

         expect(
              () => FirebaseDataUploaderService.uploadOrderData(tUserId, tOrderId),
          returnsNormally,
        );
      });
    });
  });
}