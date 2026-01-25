import 'package:flowers_app/Features/user_address/data/models/add_address_request.dart';
import 'package:flowers_app/Features/user_address/data/models/address_response_model.dart';

abstract class UserAddressRemoteDataSourceContract {
  Future<AddressResponseModel> addAddress(AddAddressRequest request);
  Future<AddressResponseModel> getAddresses();
}
