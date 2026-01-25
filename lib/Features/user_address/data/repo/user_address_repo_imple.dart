import 'package:flowers_app/Features/user_address/data/data_sources/user_address_remote_data_source_contract.dart';
import 'package:flowers_app/Features/user_address/data/mappers/address_mapper.dart';
import 'package:flowers_app/Features/user_address/data/models/delete_address_response/delete_address_response.dart';
import 'package:flowers_app/Features/user_address/data/models/edit_address_request/edit_address_request.dart';
import 'package:flowers_app/Features/user_address/data/models/edit_address_response/edit_address_response.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_response_entity.dart';
import 'package:flowers_app/Features/user_address/domain/repo/user_address_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/helpers/api_execution_mixin.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: UserAddressRepoContract)
class UserAddressRepoImple with ApiExecutionMixin implements UserAddressRepoContract {
  final UserAddressRemoteDataSourceContract _remoteDataSource;
  UserAddressRepoImple(this._remoteDataSource);
  @override
  Future<BaseResponse<AddressResponseEntity>> deleteAddress(String id) {
    return execute<DeleteAddressResponse,AddressResponseEntity>(   
      action: () => _remoteDataSource.deleteAddress(id),
      mapper: (response) => response.toEntity(),);
  }

  @override
  Future<BaseResponse<AddressResponseEntity>> editAddress(EditAddressRequest editAddressRequest, String id) {
    return execute<EditAddressResponse,AddressResponseEntity>(   
      action: () => _remoteDataSource.editAddress(editAddressRequest, id),
      mapper: (response) => response.toEntity(),);
  }
}