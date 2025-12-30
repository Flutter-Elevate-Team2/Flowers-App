import 'package:flowers_app/Features/products/data/models/products_model/products_response.dart';

abstract class ProductsRemoteDataSourceContract {
  Future<ProductsResponse> getProducts({
    String? categoryId,
    String? occasionId,
    String? sort,
    String? search,
    int? page,
    int? limit,
  });
}