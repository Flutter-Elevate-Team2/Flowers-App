import 'dart:io';

import 'package:flowers_app/Features/profile/data/models/edit_profile_request.dart';
import 'package:flowers_app/Features/profile/domain/entities/change_password_entity.dart';
import 'package:flowers_app/Features/profile/domain/entities/user_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';

abstract class ProfileRepoContract {
  Future<BaseResponse<UserEntity>> getProfileData();
  Future<BaseResponse<UserEntity>> editProfile(EditProfileRequest request);
  Future<BaseResponse<String>> uploadPhoto(File file);
  Future<BaseResponse<ChangePasswordEntity>> changePassword(
    String oldPassword,
    String newPassword,
  );
  Future<BaseResponse<String>> logout();
}
