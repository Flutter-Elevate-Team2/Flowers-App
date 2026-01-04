import 'package:flowers_app/Features/commerce/products/domain/entities/paginated_products_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';

abstract class ProductsRepoContract {
  Future<BaseResponse<PaginatedProductsEntity>> getProducts({
    String? categoryId,
    String? occasionId,
    String? sort,
    String? search,
    int? page,
    int? limit,
  });
}
