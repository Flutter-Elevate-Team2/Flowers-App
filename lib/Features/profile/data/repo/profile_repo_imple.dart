import 'dart:io';

import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_local_data_source_contract.dart';
import 'package:flowers_app/Features/profile/data/mappers/change_password_mapper.dart';
import 'package:flowers_app/Features/profile/data/mappers/profile_mapper.dart';
import 'package:flowers_app/Features/profile/data/models/change_password_request.dart';
import 'package:flowers_app/Features/profile/data/models/change_password_response.dart';
import 'package:flowers_app/Features/profile/data/models/edit_profile_request.dart';
import 'package:flowers_app/Features/profile/data/models/logout_response.dart';
import 'package:flowers_app/Features/profile/data/models/profile_dto.dart';
import 'package:flowers_app/Features/profile/data/models/upload_photo_response.dart';
import 'package:flowers_app/Features/profile/domain/entities/change_password_entity.dart';
import 'package:flowers_app/core/constants/error_strings.dart';
import 'package:flowers_app/core/controller/session_controller.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/base_response/base_response.dart';
import '../../../../core/helpers/api_execution_mixin.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repo/profile_repo_contract.dart';
import '../data_sources/remote_data_source_contract/profile_remote_data_source_contract.dart';

@Injectable(as: ProfileRepoContract)
class ProfileRepoImpl with ApiExecutionMixin implements ProfileRepoContract {
  final ProfileRemoteDataSourceContract _remoteDataSource;
  final AuthLocalDataSourceContract _authLocalDataSource;
  final SessionController _sessionController;

  ProfileRepoImpl(
    this._remoteDataSource,
    this._authLocalDataSource,
    this._sessionController,
  );

  @override
  Future<BaseResponse<UserEntity>> getProfileData() async {
    final result = await execute<ProfileDto, UserEntity>(
      action: () async => await _remoteDataSource.getProfile(),
      mapper: (response) => response.toEntity(),
    );

    if (result is SuccessResponse<UserEntity>) {
      await _authLocalDataSource.saveUserId(result.data.id);
    }

    return result;
  }

  @override
  Future<BaseResponse<UserEntity>> editProfile(
    EditProfileRequest request,
  ) async {
    final result = await execute<ProfileDto, UserEntity>(
      action: () async => await _remoteDataSource.editProfile(request),
      mapper: (response) => response.toEntity(),
    );

    if (result is SuccessResponse<UserEntity>) {
      await _authLocalDataSource.saveUserId(result.data.id);
    }

    return result;
  }

  @override
  Future<BaseResponse<String>> uploadPhoto(File file) async {
    return execute<UploadPhotoResponse, String>(
      action: () async => await _remoteDataSource.uploadPhoto(file),
      mapper: (response) => response.message,
    );
  }

  @override
  Future<BaseResponse<ChangePasswordEntity>> changePassword(
    String oldPassword,
    String newPassword,
  ) async {
    final request = ChangePasswordRequest(
      password: oldPassword,
      newPassword: newPassword,
    );

    final result = await execute<ChangePasswordResponse, ChangePasswordEntity>(
      action: () async => await _remoteDataSource.changePassword(request),
      mapper: (response) => response.toEntity(),
    );

    if (result is SuccessResponse<ChangePasswordEntity>) {
      final newToken = result.data.token;
      await _authLocalDataSource.clearUserData();
      await _authLocalDataSource.saveToken(newToken);
    }

    return result;
  }

  @override
  Future<BaseResponse<String>> logout() async {
    final result = await execute<LogoutResponse, String>(
      action: () async => await _remoteDataSource.logout(),
      mapper: (response) => response.message,
    );

    Future<void> performLocalLogout() async {
      await _authLocalDataSource.clearUserData();
      _sessionController.notifyLogout(SessionEndReason.logout);
    }

    if (result is SuccessResponse) {
      await performLocalLogout();
    } else if (result is ErrorResponse) {
      final error = result as ErrorResponse;
      if (error.errorMessage == ErrorStrings.unauthorized) {
        await performLocalLogout();
        return SuccessResponse(data: "Logged out successfully");
      }
    }

    return result;
  }
}
