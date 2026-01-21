import 'dart:io';

import 'package:flowers_app/Features/profile/data/models/change_password_request.dart';
import 'package:flowers_app/Features/profile/data/models/change_password_response.dart';
import 'package:flowers_app/Features/profile/data/models/edit_profile_request.dart';
import 'package:flowers_app/Features/profile/data/models/logout_response.dart';
import 'package:flowers_app/Features/profile/data/models/profile_dto.dart';
import 'package:flowers_app/Features/profile/data/models/upload_photo_response.dart';

abstract class ProfileRemoteDataSourceContract {
  Future<ProfileDto> getProfile();
  Future<ProfileDto> editProfile(EditProfileRequest request);
  Future<UploadPhotoResponse> uploadPhoto(File file);
  Future<ChangePasswordResponse> changePassword(ChangePasswordRequest request);
  Future<LogoutResponse> logout();
}
