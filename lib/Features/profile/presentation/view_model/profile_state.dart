import 'package:flowers_app/Features/profile/domain/entities/change_password_entity.dart';
import 'package:flowers_app/Features/profile/domain/entities/user_entity.dart';
import 'package:flowers_app/core/base_states/base_states.dart';

class ProfileState {
  final BaseState<UserEntity>? profileState;
  final BaseState<UserEntity>? editProfileState;
  final BaseState<ChangePasswordEntity>? changePasswordState;
  final BaseState<String>? uploadPhotoState;

  ProfileState({
    this.profileState,
    this.editProfileState,
    this.changePasswordState,
    this.uploadPhotoState,
  });

  ProfileState copyWith({
    BaseState<UserEntity>? profileState,
    BaseState<UserEntity>? editProfileState,
    BaseState<ChangePasswordEntity>? changePasswordState,
    BaseState<String>? uploadPhotoState,
  }) {
    return ProfileState(
      profileState: profileState ?? this.profileState,
      editProfileState: editProfileState ?? this.editProfileState,
      changePasswordState: changePasswordState ?? this.changePasswordState,
      uploadPhotoState: uploadPhotoState ?? this.uploadPhotoState,
    );
  }
}
