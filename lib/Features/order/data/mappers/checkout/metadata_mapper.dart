import 'package:flowers_app/Features/order/domain/entities/checkout/orders_metadata_entity.dart';
import 'package:flowers_app/Features/order/data/models/checkout/orders_metadata_dto.dart';

extension MetadataMapper on Metadata {
  OrdersMetadata toEntity() {
    return OrdersMetadata(
      currentPage: currentPage,
      totalItems: totalItems,
      totalPages: totalPages,
      limit: limit,
    );
  }
}
