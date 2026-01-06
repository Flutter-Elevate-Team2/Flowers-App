import 'dart:io';

import 'package:flowers_app/Features/profile/api/api_client/profile_api_client.dart';
import 'package:flowers_app/Features/profile/data/data_sources/remote_data_source_contract/profile_remote_data_source_contract.dart';
import 'package:flowers_app/Features/profile/data/models/change_password_request.dart';
import 'package:flowers_app/Features/profile/data/models/change_password_response.dart';
import 'package:flowers_app/Features/profile/data/models/edit_profile_request.dart';
import 'package:flowers_app/Features/profile/data/models/profile_dto.dart';
import 'package:flowers_app/Features/profile/data/models/upload_photo_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDataSourceContract)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSourceContract {
  final ProfileApi _profileApi;

  ProfileRemoteDataSourceImpl(this._profileApi);

  @override
  Future<ProfileDto> getProfile() async {
    return await _profileApi.getProfile();
  }

  @override
  Future<ProfileDto> editProfile(EditProfileRequest request) async {
    return await _profileApi.editProfile(request);
  }

  @override
  Future<UploadPhotoResponse> uploadPhoto(File file) async {
    return await _profileApi.uploadPhoto(file);
  }

  @override
  Future<ChangePasswordResponse> changePassword(
    ChangePasswordRequest request,
  ) async {
    return await _profileApi.changePassword(request);
  }
}
