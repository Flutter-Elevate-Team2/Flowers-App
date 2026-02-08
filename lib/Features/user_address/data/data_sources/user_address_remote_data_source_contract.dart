import 'package:flowers_app/Features/user_address/data/models/add_address_request.dart';
import 'package:flowers_app/Features/user_address/data/models/address_response_model.dart';
import 'package:flowers_app/Features/user_address/data/models/edit_address_request/edit_address_request.dart';

abstract class UserAddressRemoteDataSourceContract {
  Future<AddressResponseModel> editAddress(
    EditAddressRequest editAddressRequest,
    String id,
  );
  Future<AddressResponseModel> deleteAddress(String id);
  Future<AddressResponseModel> addAddress(AddAddressRequest request);
  Future<AddressResponseModel> getAddresses();
}
