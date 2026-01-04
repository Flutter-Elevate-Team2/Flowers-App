import 'package:flowers_app/Features/commerce/products/data/models/products_model/products_response.dart';
import 'package:flowers_app/Features/commerce/products/domain/entities/meta_data_entity.dart';
import 'package:flowers_app/core/constants/api_constants.dart';

extension MetadataMapper on Metadata {
  MetaDataEntity toEntity() {
    return MetaDataEntity(
      currentPage: currentPage ?? ApiConstants.defaultCurrentPage,
      totalPages: totalPages ?? ApiConstants.defaultTotalPages,
      limit : limit ?? ApiConstants.defaultLimit,
      totalItems: totalItems ?? ApiConstants.defaultTotalItems,
      nextPage: nextPage,
      prevPage: prevPage,
    );
  }
}
