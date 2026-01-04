import 'package:flowers_app/Features/commerce/home/api/api_client/home_api.dart';
import 'package:flowers_app/Features/commerce/home/data/data_source_contract/home_remote_data_source_contract.dart';
import 'package:flowers_app/Features/commerce/home/data/models/home_response/home_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRemoteDataSourceContract)
class HomeRemoteDataSource implements HomeRemoteDataSourceContract {
  final HomeApi _homeApi;

  HomeRemoteDataSource(this._homeApi);
  @override
  Future<HomeResponse> getHomeSections() async {
    return await _homeApi.getHomeSections();
  }
}
