import 'package:flowers_app/Features/products/domain/entities/products_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';

abstract class ProductsRepoContract {
  Future<BaseResponse<List<ProductsEntity>>> getProducts({
    String? categoryId,
    String? occasionId,
    String? sort,
  });
}
