import 'package:flowers_app/Features/commerce/data/models/home_response/home_response.dart';
import 'package:flowers_app/Features/commerce/data/models/products_model/products_response.dart';

abstract class CommerceRemoteDataSourceContract {
  Future<HomeResponse> getHomeSections();

  Future<ProductsResponse> getProducts({
    String? categoryId,
    String? occasionId,
    String? sort,
    String? search,
    int? page,
    int? limit,
  });
}
