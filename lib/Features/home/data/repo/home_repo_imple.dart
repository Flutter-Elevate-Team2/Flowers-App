import 'package:flowers_app/Features/home/data/data_source_contract/home_remote_data_source_contract.dart';
import 'package:flowers_app/Features/home/data/models/home_response/home_mappers.dart';
import 'package:flowers_app/Features/home/data/models/home_response/home_response.dart';
import 'package:flowers_app/Features/home/domain/entities/home_entities/home_entity.dart';
import 'package:flowers_app/Features/home/domain/repo/home_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/helpers/api_execution_mixin.dart';

import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepoContract)
class HomeRepoImple with ApiExecutionMixin implements HomeRepoContract {
  final HomeRemoteDataSourceContract _homeRemoteDataSource;

  HomeRepoImple(this._homeRemoteDataSource);
  @override
  Future<BaseResponse<HomeEntity>> getHomeSections() {
    return execute<HomeResponse, HomeEntity>(
      action: () => _homeRemoteDataSource.getHomeSections(),
      mapper: (response) => response.toEntity(),
    );
  }
}
