import 'package:flowers_app/Features/user_address/data/data_sources/user_address_remote_data_source_contract.dart';
import 'package:flowers_app/Features/user_address/data/mappers/address_mapper.dart';
import 'package:flowers_app/Features/user_address/data/models/add_address_request.dart';
import 'package:flowers_app/Features/user_address/data/models/address_response_model.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_response_entity.dart';
import 'package:flowers_app/Features/user_address/domain/repo/user_address_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/helpers/api_execution_mixin.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserAddressRepoContract)
class UserAddressRepoImple with ApiExecutionMixin implements UserAddressRepoContract {
  final UserAddressRemoteDataSourceContract _remoteDataSource;

  UserAddressRepoImple(this._remoteDataSource);

  @override
  Future<BaseResponse<AddressResponseEntity>> addAddress(AddAddressRequest request) {
    return execute<AddressResponseModel, AddressResponseEntity>(
      action: () => _remoteDataSource.addAddress(request),
      mapper: (response) => response.toEntity(),
    );
  }
  @override
  Future<BaseResponse<AddressResponseEntity>> getAddresses() {
    return execute<AddressResponseModel, AddressResponseEntity>(
      action: () => _remoteDataSource.getAddresses(),
      mapper: (response) => response.toEntity(),
    );
  }
}
