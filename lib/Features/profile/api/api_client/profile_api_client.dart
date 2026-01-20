import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flowers_app/Features/profile/data/models/change_password_request.dart';
import 'package:flowers_app/Features/profile/data/models/change_password_response.dart';
import 'package:flowers_app/Features/profile/data/models/edit_profile_request.dart';
import 'package:flowers_app/Features/profile/data/models/logout_response.dart';
import 'package:flowers_app/Features/profile/data/models/profile_dto.dart';
import 'package:flowers_app/Features/profile/data/models/upload_photo_response.dart';
import 'package:flowers_app/core/constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'profile_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class ProfileApi {
  @factoryMethod
  factory ProfileApi(Dio dio) = _ProfileApi;

  @GET(ApiConstants.getProfile)
  @Extra({'cache_policy': CachePolicy.noCache})
  Future<ProfileDto> getProfile();
  @PUT(ApiConstants.editProfile)
  Future<ProfileDto> editProfile(@Body() EditProfileRequest request);
  @POST(ApiConstants.uploadPhoto)
  @MultiPart()
  Future<UploadPhotoResponse> uploadPhoto(@Part(name: "photo") File photo);
  @PATCH(ApiConstants.changePassword)
  Future<ChangePasswordResponse> changePassword(@Body() ChangePasswordRequest request);
  @GET(ApiConstants.logout)
  Future<LogoutResponse> logout();
}
