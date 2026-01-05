import 'package:flowers_app/Features/commerce/api/api_client/commerce_api.dart';
import 'package:flowers_app/Features/commerce/data/commerce_data_source_contract/commerce_remote_data_source_contract.dart';
import 'package:flowers_app/Features/commerce/data/models/home_response/home_response.dart';
import 'package:flowers_app/Features/commerce/data/models/products_model/products_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CommerceRemoteDataSourceContract)
class CommerceRemoteDataSourceImpl implements CommerceRemoteDataSourceContract {
  final CommerceApi _api;

  CommerceRemoteDataSourceImpl(this._api);

  @override
  Future<HomeResponse> getHomeSections() {
    return _api.getHomeSections();
  }

  @override
  Future<ProductsResponse> getProducts({
    String? categoryId,
    String? occasionId,
    String? sort,
    String? search,
    int? page,
    int? limit,
  }) {
    return _api.getProducts(
      categoryId: categoryId,
      occasionId: occasionId,
      sort: sort,
      search: search,
      page: page,
      limit: limit,
    );
  }
}
