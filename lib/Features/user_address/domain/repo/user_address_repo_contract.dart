import 'package:flowers_app/Features/user_address/data/models/edit_address_request/edit_address_request.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_response_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';

abstract class UserAddressRepoContract {
  Future<BaseResponse<AddressResponseEntity>>editAddress(
    EditAddressRequest editAddressRequest,
    String id
  ); 
  Future<BaseResponse<AddressResponseEntity>>deleteAddress(String id); 
}
