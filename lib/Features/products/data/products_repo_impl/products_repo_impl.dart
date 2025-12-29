import 'package:flowers_app/Features/products/data/mappers/product_mapper.dart';
import 'package:flowers_app/Features/products/data/models/products_model/products_response.dart';
import 'package:flowers_app/Features/products/data/products_data_source_contract/products_data_source_contract.dart';
import 'package:flowers_app/Features/products/domain/entities/products_entity.dart';
import 'package:flowers_app/Features/products/domain/products_repo_contract/products_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/helpers/api_execution_mixin.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductsRepoContract)
class ProductsRepoImpl
    with ApiExecutionMixin
    implements ProductsRepoContract {
  final ProductsRemoteDataSourceContract _remoteDataSource;

  ProductsRepoImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<List<ProductsEntity>>> getProducts({
    String? categoryId,
    String? occasionId,
    String? sort,
  }) {
    return execute<ProductsResponse, List<ProductsEntity>>(
      action: () async => await _remoteDataSource.getProducts(
        categoryId: categoryId,
        occasionId: occasionId,
        sort: sort,
      ),
      mapper: (response) {
        return response.products
            ?.map((product) => product.toEntity())
            .toList() ??
            [];
      },
    );
  }
}