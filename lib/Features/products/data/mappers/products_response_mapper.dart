import 'package:flowers_app/Features/products/data/mappers/meta_data_mapper.dart';
import 'package:flowers_app/Features/products/data/mappers/product_mapper.dart';
import 'package:flowers_app/Features/products/data/models/products_model/products_response.dart';
import 'package:flowers_app/Features/products/domain/entities/meta_data_entity.dart';
import 'package:flowers_app/Features/products/domain/entities/paginated_products_entity.dart';
import 'package:flowers_app/core/constants/api_constants.dart';

extension ProductsResponseMapper on ProductsResponse {
  PaginatedProductsEntity toPaginatedEntity() {
    return PaginatedProductsEntity(
      products: products?.map((p) => p.toEntity()).toList() ?? [],
      meta:
          metadata?.toEntity() ??
          MetaDataEntity(
            currentPage: ApiConstants.defaultCurrentPage,
            totalPages: ApiConstants.defaultTotalPages,
            limit: ApiConstants.defaultLimit,
            totalItems: ApiConstants.defaultTotalItems,
          ),
    );
  }
}
