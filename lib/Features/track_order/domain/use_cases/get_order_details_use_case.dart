import 'package:flowers_app/core/services/firebase_data_uploader_service.dart';
import 'package:injectable/injectable.dart';
import 'package:flowers_app/Features/track_order/data/mapper/order_tracking_mapper.dart';
import 'package:flowers_app/Features/track_order/domain/entities/order_tracking_entity.dart';

@injectable
class GetOrderDetailsUseCase {
  final FirebaseDataUploaderService _firebaseService;

  GetOrderDetailsUseCase(this._firebaseService);

  Future<OrderTrackingEntity?> call(String orderId) async {
    final firebaseModel = await _firebaseService.getTrackingOrderById(orderId);
    return firebaseModel?.toEntity();
  }
}
