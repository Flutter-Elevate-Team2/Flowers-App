import 'package:flowers_app/Features/products/data/models/products_model/products_response.dart';
import 'package:flowers_app/Features/products/domain/entities/meta_data_entity.dart';

extension MetadataMapper on Metadata {
  MetaDataEntity toEntity() {
    return MetaDataEntity(
      currentPage: currentPage ?? 1,
      totalPages: totalPages ?? 1,
      limit: limit ?? 20,
      totalItems: totalItems ?? 0,
      nextPage: nextPage,
      prevPage: prevPage,
    );
  }
}