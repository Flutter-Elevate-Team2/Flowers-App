import 'package:flowers_app/Features/products/data/models/products_model/products_response.dart';
import 'package:flowers_app/Features/products/domain/entities/meta_data_entity.dart';
import 'package:flowers_app/core/constants/api_constants.dart';

extension MetadataMapper on Metadata {
  MetadataEntity toEntity() {
    return MetadataEntity(
      currentPage: currentPage ?? ApiConstants.defaultCurrentPage,
      totalPages: totalPages ?? ApiConstants.defaultTotalPages,
      limit : limit ?? ApiConstants.defaultLimit,
      totalItems: totalItems ?? ApiConstants.defaultTotalItems,
      nextPage: nextPage,
      prevPage: prevPage,
    );
  }
}