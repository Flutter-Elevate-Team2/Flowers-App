import 'package:dio/dio.dart';
import 'package:flowers_app/Features/user_address/data/models/add_address_request.dart';
import 'package:flowers_app/Features/user_address/data/models/address_response_model.dart';
import 'package:flowers_app/core/constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'user_address_api.g.dart';

@lazySingleton
@RestApi()
abstract class UserAddressApi {
  @factoryMethod
  factory UserAddressApi(Dio dio) = _UserAddressApi;

  @PATCH(ApiConstants.addresses)
  Future<AddressResponseModel> addAddress(@Body() AddAddressRequest request);
  @GET(ApiConstants.addresses)
  Future<AddressResponseModel> getAddresses();
}
