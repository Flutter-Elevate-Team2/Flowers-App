import 'package:flowers_app/Features/commerce/data/commerce_data_source_contract/commerce_remote_data_source_contract.dart';
import 'package:flowers_app/Features/commerce/data/mappers/home_mappers.dart';
import 'package:flowers_app/Features/commerce/data/mappers/products_response_mapper.dart';
import 'package:flowers_app/Features/commerce/data/models/home_response/home_response.dart';
import 'package:flowers_app/Features/commerce/data/models/products_model/products_response.dart';
import 'package:flowers_app/Features/commerce/domain/entities/home_entities/home_entity.dart';
import 'package:flowers_app/Features/commerce/domain/entities/product_entities/paginated_products_entity.dart';
import 'package:flowers_app/Features/commerce/domain/repos/commerce_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/helpers/api_execution_mixin.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CommerceRepoContract)
class CommerceRepoImpl with ApiExecutionMixin implements CommerceRepoContract {
  final CommerceRemoteDataSourceContract _remoteDataSource;

  CommerceRepoImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<HomeEntity>> getHomeSections() {
    return execute<HomeResponse, HomeEntity>(
      action: () => _remoteDataSource.getHomeSections(),
      mapper: (response) => response.toEntity(),
    );
  }

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
      action: () => _remoteDataSource.getProducts(
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
