import 'dart:io';

import 'package:flowers_app/Features/profile/data/mappers/change_password_mapper.dart';
import 'package:flowers_app/Features/profile/data/mappers/profile_mapper.dart';
import 'package:flowers_app/Features/profile/data/models/change_password_request.dart';
import 'package:flowers_app/Features/profile/data/models/change_password_response.dart';
import 'package:flowers_app/Features/profile/data/models/edit_profile_request.dart';
import 'package:flowers_app/Features/profile/data/models/profile_dto.dart';
import 'package:flowers_app/Features/profile/data/models/upload_photo_response.dart';
import 'package:flowers_app/Features/profile/domain/entities/change_password_entity.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/base_response/base_response.dart';
import '../../../../core/helpers/api_execution_mixin.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repo/profile_repo_contract.dart';
import '../data_sources/remote_data_source_contract/profile_remote_data_source_contract.dart';

@Injectable(as: ProfileRepoContract)
class ProfileRepoImpl with ApiExecutionMixin implements ProfileRepoContract {
  final ProfileRemoteDataSourceContract _remoteDataSource;

  ProfileRepoImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<UserEntity>> getProfileData() async {
    return execute<ProfileDto, UserEntity>(
      action: () async => await _remoteDataSource.getProfile(),
      mapper: (response) => response.toEntity(),
    );
  }
  @override
  Future<BaseResponse<UserEntity>> editProfile(EditProfileRequest request) async {
    return execute<ProfileDto, UserEntity>(
      action: () async => await _remoteDataSource.editProfile(request),
      mapper: (response) => response.toEntity(),
    );
  }
  @override
  Future<BaseResponse<String>> uploadPhoto(File file) async {
    return execute<UploadPhotoResponse, String>(
      action: () async => await _remoteDataSource.uploadPhoto(file),
      mapper: (response) => response.message,
    );
  }
 @override
  Future<BaseResponse<ChangePasswordEntity>> changePassword(ChangePasswordRequest request) async {
    return execute<ChangePasswordResponse, ChangePasswordEntity>(
      action: () async => await _remoteDataSource.changePassword(request),
      mapper: (response) => response.toEntity(),
    );
  }
}
