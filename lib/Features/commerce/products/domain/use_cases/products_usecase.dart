import 'package:flowers_app/Features/commerce/products/domain/entities/paginated_products_entity.dart';
import 'package:flowers_app/Features/commerce/products/domain/products_repo_contract/products_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductsUseCase {
  final ProductsRepoContract _productsRepoContract;

  ProductsUseCase(this._productsRepoContract);

  Future<BaseResponse<PaginatedProductsEntity>> getProducts({
    String? categoryId,
    String? occasionId,
    String? sort,
    String? search,
    int? page,
    int? limit,
  }) {
    return _productsRepoContract.getProducts(
      categoryId: categoryId,
      occasionId: occasionId,
      sort: sort,
      search: search,
      page: page,
      limit: limit,
    );
  }
}
