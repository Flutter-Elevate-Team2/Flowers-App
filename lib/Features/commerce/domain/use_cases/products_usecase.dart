import 'package:flowers_app/Features/commerce/domain/entities/product_entities/paginated_products_entity.dart';
import 'package:flowers_app/Features/commerce/domain/repos/commerce_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductsUseCase {
  final CommerceRepoContract _repo;

  ProductsUseCase(this._repo);

  Future<BaseResponse<PaginatedProductsEntity>> getProducts({
    String? categoryId,
    String? occasionId,
    String? sort,
    String? search,
    int? page,
    int? limit,
  }) {
    return _repo.getProducts(
      categoryId: categoryId,
      occasionId: occasionId,
      sort: sort,
      search: search,
      page: page,
      limit: limit,
    );
  }
}
