import 'dart:io';

import 'package:flowers_app/Features/profile/data/models/edit_profile_request.dart';

sealed class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {}

class EditProfileEvent extends ProfileEvent {
  final EditProfileRequest request;
  EditProfileEvent(this.request);
}

class ChangePasswordEvent extends ProfileEvent {
  final String oldPassword;
  final String newPassword;
  ChangePasswordEvent({required this.oldPassword, required this.newPassword});
}

class UploadPhotoEvent extends ProfileEvent {
  final File file;
  UploadPhotoEvent(this.file);
}

class SelectProfileImageEvent extends ProfileEvent {
  final File image;
  SelectProfileImageEvent(this.image);
}

class LogoutEvent extends ProfileEvent {}
