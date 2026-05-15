import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowers_app/Features/notifications/data/data_source_contract/notification_remote_data_source_contract.dart';
import 'package:flowers_app/Features/notifications/data/models/notification_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotificationRemoteDataSourceContract)
class NotificationRemoteDataSourceImpl
    implements NotificationRemoteDataSourceContract {
  final FirebaseFirestore _firestore;

  NotificationRemoteDataSourceImpl(this._firestore);

  @override
  Stream<List<NotificationModel>> getNotifications(String userId) {
    return _firestore
        .collection('notifications')
        .where('receiverId', isEqualTo: userId)
        .orderBy('sentAt', descending: true)
        .snapshots()
        .map((QuerySnapshot snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            data['id'] = doc.id;
            return NotificationModel.fromJson(data);
          }).toList();
        });
  }

  @override
  Future<void> markNotificationAsRead(String notificationId) async {
    try {
      await _firestore.collection('notifications').doc(notificationId).update({
        'isRead': true,
      });
    } on FirebaseException {
      // Rethrow so the repository layer can map it via ErrorHandler.handleError()
      rethrow;
    } catch (e) {
      // Rethrow all other exceptions (network, platform, etc.)
      rethrow;
    }
  }
}
