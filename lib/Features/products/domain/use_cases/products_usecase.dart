import 'package:flowers_app/Features/products/domain/entities/products_entity.dart';
import 'package:flowers_app/Features/products/domain/products_repo_contract/products_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductsUseCase {
  final ProductsRepoContract _productsRepoContract;

  ProductsUseCase(this._productsRepoContract);

  Future<BaseResponse<List<ProductsEntity>>> getProducts({
    String? categoryId,
    String? occasionId,
    String? sort,
  }) {
    return _productsRepoContract.getProducts(
      categoryId: categoryId,
      occasionId: occasionId,
      sort: sort
    );
  }
}
