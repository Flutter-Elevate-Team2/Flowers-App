import 'package:flowers_app/Features/user_address/data/models/delete_address_response/delete_address_response.dart';
import 'package:flowers_app/Features/user_address/data/models/edit_address_request/edit_address_request.dart';
import 'package:flowers_app/Features/user_address/data/models/edit_address_response/edit_address_response.dart';

abstract class UserAddressRemoteDataSourceContract {
  Future<EditAddressResponse> editAddress(
    EditAddressRequest editAddressRequest,
    String id
  );
  Future<DeleteAddressResponse> deleteAddress(String id);
}
