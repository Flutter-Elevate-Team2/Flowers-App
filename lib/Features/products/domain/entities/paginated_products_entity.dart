import 'package:flowers_app/Features/products/domain/entities/meta_data_entity.dart';
import 'package:flowers_app/Features/products/domain/entities/product_entity.dart';

class PaginatedProductsEntity {
  final List<ProductEntity> products;
  final MetaDataEntity  meta;

  PaginatedProductsEntity({
    required this.products,
    required this.meta,
  });
}
