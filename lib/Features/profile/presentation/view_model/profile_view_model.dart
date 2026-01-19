import 'package:flowers_app/Features/profile/data/models/edit_profile_request.dart';
import 'package:flowers_app/Features/profile/domain/entities/change_password_entity.dart';
import 'package:flowers_app/Features/profile/domain/entities/user_entity.dart';
import 'package:flowers_app/Features/profile/domain/use_cases/change_password_use_case.dart';
import 'package:flowers_app/Features/profile/domain/use_cases/edit_profile_use_case.dart';
import 'package:flowers_app/Features/profile/domain/use_cases/profile_use_case.dart';
import 'package:flowers_app/Features/profile/domain/use_cases/upload_photo_use_case.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_event.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_state.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'dart:io';

@injectable
class ProfileViewModel extends Cubit<ProfileState> {
  final GetProfileUseCase _getProfileUseCase;
  final EditProfileUseCase _editProfileUseCase;
  final ChangePasswordUseCase _changePasswordUseCase;
  final UploadPhotoUseCase _uploadPhotoUseCase;

  ProfileViewModel(
    this._getProfileUseCase,
    this._editProfileUseCase,
    this._changePasswordUseCase,
    this._uploadPhotoUseCase,
  ) : super(ProfileState());

  void doIntent(ProfileEvent event) {
    switch (event) {
      case GetProfileEvent():
        _getProfile();
        break;
      case EditProfileEvent():
        _editProfile(event.request);
        break;
      case ChangePasswordEvent():
        _changePassword(event.oldPassword, event.newPassword);
        break;
      case UploadPhotoEvent():
        _uploadPhoto(event.file);
        break;
    }
  }

  Future<void> _getProfile() async {
    emit(state.copyWith(profileState: BaseState(isLoading: true)));
    final response = await _getProfileUseCase.call();
    switch (response) {
      case SuccessResponse<UserEntity>():
        emit(
          state.copyWith(
            profileState: BaseState(isLoading: false, data: response.data),
          ),
        );
        break;
      case ErrorResponse<UserEntity>():
        emit(
          state.copyWith(
            profileState: BaseState(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
        break;
    }
  }

  Future<void> _editProfile(EditProfileRequest request) async {
    emit(state.copyWith(editProfileState: BaseState(isLoading: true)));
    final response = await _editProfileUseCase.call(request);
    switch (response) {
      case SuccessResponse<UserEntity>():
        emit(
          state.copyWith(
            editProfileState: BaseState(isLoading: false, data: response.data),
            // Update profile data as well to reflect changes
            profileState: BaseState(isLoading: false, data: response.data),
          ),
        );
        break;
      case ErrorResponse<UserEntity>():
        emit(
          state.copyWith(
            editProfileState: BaseState(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
        break;
    }
  }

  Future<void> _changePassword(String oldPassword, String newPassword) async {
    emit(state.copyWith(changePasswordState: BaseState(isLoading: true)));
    final response = await _changePasswordUseCase.call(
      oldPassword,
      newPassword,
    );
    switch (response) {
      case SuccessResponse<ChangePasswordEntity>():
        emit(
          state.copyWith(
            changePasswordState: BaseState(
              isLoading: false,
              data: response.data,
            ),
          ),
        );
        break;
      case ErrorResponse<ChangePasswordEntity>():
        emit(
          state.copyWith(
            changePasswordState: BaseState(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
        break;
    }
  }

  Future<void> _uploadPhoto(File file) async {
    emit(state.copyWith(uploadPhotoState: BaseState(isLoading: true)));
    final response = await _uploadPhotoUseCase.call(file);
    switch (response) {
      case SuccessResponse<String>():
        emit(
          state.copyWith(
            uploadPhotoState: BaseState(isLoading: false, data: response.data),
          ),
        );
        _getProfile();
        break;
      case ErrorResponse<String>():
        emit(
          state.copyWith(
            uploadPhotoState: BaseState(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
        break;
    }
  }
}
