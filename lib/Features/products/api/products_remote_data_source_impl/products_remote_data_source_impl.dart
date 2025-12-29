import 'package:flowers_app/Features/products/api/api_client/products_api.dart';
import 'package:flowers_app/Features/products/data/models/products_model/products_response.dart';
import 'package:flowers_app/Features/products/data/products_data_source_contract/products_data_source_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductsRemoteDataSourceContract)
class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSourceContract {
  final ProductsApi _productsApi;

  ProductsRemoteDataSourceImpl(this._productsApi);

  @override
  Future<ProductsResponse> getProducts({
    String? categoryId,
    String? occasionId,
    String? sort,
  }) {
    return _productsApi.getProducts(
      categoryId: categoryId,
      occasionId: occasionId,
      sort: sort
    );
  }
}
