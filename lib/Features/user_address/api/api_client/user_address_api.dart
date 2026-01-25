import 'package:dio/dio.dart';
import 'package:flowers_app/Features/user_address/data/models/delete_address_response/delete_address_response.dart';
import 'package:flowers_app/Features/user_address/data/models/edit_address_request/edit_address_request.dart';
import 'package:flowers_app/Features/user_address/data/models/edit_address_response/edit_address_response.dart';
import 'package:flowers_app/core/constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'user_address_api.g.dart';

@lazySingleton
@RestApi()
abstract class UserAddressApi {
  @factoryMethod
  factory UserAddressApi(Dio dio) = _UserAddressApi;

  @PATCH(ApiConstants.address)
  Future<EditAddressResponse> editAddress(
    @Path("id") String id,
    @Body() EditAddressRequest body);
  @DELETE(ApiConstants.address)
  Future<DeleteAddressResponse> deleteAddress(@Path("id") String id);
}
