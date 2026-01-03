import 'package:flowers_app/Features/products/data/mappers/products_response_mapper.dart';
import 'package:flowers_app/Features/products/data/models/products_model/products_response.dart';
import 'package:flowers_app/Features/products/data/products_data_source_contract/products_data_source_contract.dart';
import 'package:flowers_app/Features/products/domain/entities/paginated_products_entity.dart';
import 'package:flowers_app/Features/products/domain/products_repo_contract/products_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/helpers/api_execution_mixin.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductsRepoContract)
class ProductsRepoImpl with ApiExecutionMixin implements ProductsRepoContract {
  final ProductsRemoteDataSourceContract _remoteDataSource;

  ProductsRepoImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<PaginatedProductsEntity>> getProducts({
    String? categoryId,
    String? occasionId,
    String? sort,
    String? search,
    int? page,
    int? limit,
  }) {
    return execute<ProductsResponse, PaginatedProductsEntity>(
      action: () async => await _remoteDataSource.getProducts(
        categoryId: categoryId,
        occasionId: occasionId,
        sort: sort,
        search: search,
        page: page,
        limit: limit,
      ),
      mapper: (response) => response.toPaginatedEntity(),
    );
  }
}
