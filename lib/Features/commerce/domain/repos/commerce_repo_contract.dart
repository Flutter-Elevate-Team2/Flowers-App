import 'package:flowers_app/Features/commerce/domain/entities/home_entities/home_entity.dart';
import 'package:flowers_app/Features/commerce/domain/entities/product_entities/paginated_products_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';

abstract class CommerceRepoContract {
  Future<BaseResponse<HomeEntity>> getHomeSections();

  Future<BaseResponse<PaginatedProductsEntity>> getProducts({
    String? categoryId,
    String? occasionId,
    String? sort,
    String? search,
    int? page,
    int? limit,
  });
}
