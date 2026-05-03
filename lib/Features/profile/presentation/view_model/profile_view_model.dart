import 'dart:async';
import 'dart:io';

import 'package:flowers_app/Features/auth/domain/use_cases/valid_token_usecase.dart';
import 'package:flowers_app/Features/profile/data/models/edit_profile_request.dart';
import 'package:flowers_app/Features/profile/domain/entities/change_password_entity.dart';
import 'package:flowers_app/Features/profile/domain/entities/user_entity.dart';
import 'package:flowers_app/Features/profile/domain/use_cases/change_password_use_case.dart';
import 'package:flowers_app/Features/profile/domain/use_cases/edit_profile_use_case.dart';
import 'package:flowers_app/Features/profile/domain/use_cases/logout_use_case.dart';
import 'package:flowers_app/Features/profile/domain/use_cases/profile_use_case.dart';
import 'package:flowers_app/Features/profile/domain/use_cases/upload_photo_use_case.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_event.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_state.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flowers_app/core/controller/session_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class ProfileViewModel extends Cubit<ProfileState> {
  final GetProfileUseCase _getProfileUseCase;
  final EditProfileUseCase _editProfileUseCase;
  final ChangePasswordUseCase _changePasswordUseCase;
  final UploadPhotoUseCase _uploadPhotoUseCase;
  final LogoutUseCase _logoutUseCase;
  final HasValidTokenUseCase _hasTokenUseCase;
  final SessionController _sessionController;
  final SharedPreferences _sharedPreferences;
  StreamSubscription? _loginSubscription;
  StreamSubscription? _logoutSubscription;

  ProfileViewModel(
    this._getProfileUseCase,
    this._editProfileUseCase,
    this._changePasswordUseCase,
    this._uploadPhotoUseCase,
    this._logoutUseCase,
    this._hasTokenUseCase,
    this._sessionController,
    this._sharedPreferences,
  ) : super(ProfileState()) {
    _listenToSession();
  }

  void _listenToSession() {
    _loginSubscription = _sessionController.onLogin.listen((_) {
      _getProfile();
    });

    _logoutSubscription = _sessionController.onLogout.listen((_) {
      if (isClosed) return;
      emit(ProfileState());
    });
  }

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
      case SelectProfileImageEvent():
        _selectProfileImage(event.image);
        break;
      case LogoutEvent():
        _logout();
        break;
    }
  }

  void loadNotificationPreference() {
    final isEnabled =
        _sharedPreferences.getBool('is_notifications_enabled') ?? true;
    if (!isClosed) {
      emit(state.copyWith(isNotificationsEnabled: isEnabled));
    }
  }

  Future<void> toggleNotifications(bool value) async {
    if (value) {
      final permission = await Permission.notification.request();
      if (permission.isGranted) {
        await _sharedPreferences.setBool('is_notifications_enabled', true);
        if (!isClosed) emit(state.copyWith(isNotificationsEnabled: true));
      } else if (permission.isPermanentlyDenied) {
        openAppSettings();
      }
    } else {
      await _sharedPreferences.setBool('is_notifications_enabled', false);
      if (!isClosed) emit(state.copyWith(isNotificationsEnabled: false));
    }
  }

  Future<void> _getProfile() async {
    final bool hasToken = await _hasTokenUseCase.call();
    if (!hasToken) {
      emit(ProfileState());
      return;
    }

    if (isClosed) return;
    emit(state.copyWith(profileState: BaseState(isLoading: true)));

    final response = await _getProfileUseCase.call();

    if (isClosed) return;
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
    if (isClosed) return;
    emit(state.copyWith(editProfileState: BaseState(isLoading: true)));
    final response = await _editProfileUseCase.call(request);
    if (isClosed) return;
    switch (response) {
      case SuccessResponse<UserEntity>():
        emit(
          state.copyWith(
            editProfileState: BaseState(isLoading: false, data: response.data),
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
    if (isClosed) return;
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
    if (isClosed) return;
    emit(state.copyWith(uploadPhotoState: BaseState(isLoading: true)));
    final response = await _uploadPhotoUseCase.call(file);
    if (isClosed) return;
    switch (response) {
      case SuccessResponse<String>():
        emit(
          state.copyWith(
            uploadPhotoState: BaseState(isLoading: false, data: response.data),
            clearSelectedImage: true,
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

  void _selectProfileImage(File image) {
    if (isClosed) return;
    emit(state.copyWith(selectedProfileImage: image));
  }

  Future<void> _logout() async {
    if (isClosed) return;
    emit(state.copyWith(logoutState: BaseState(isLoading: true)));
    final response = await _logoutUseCase.call();
    switch (response) {
      case SuccessResponse<String>():
        emit(
          state.copyWith(logoutState: BaseState(isLoading: false, data: null)),
        );
        break;
      case ErrorResponse<String>():
        emit(
          state.copyWith(
            logoutState: BaseState(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
        break;
    }
  }

  @override
  Future<void> close() {
    _loginSubscription?.cancel();
    _logoutSubscription?.cancel();
    return super.close();
  }
}
