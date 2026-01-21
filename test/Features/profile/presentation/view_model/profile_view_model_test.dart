import 'dart:io';

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
import 'package:flowers_app/Features/profile/presentation/view_model/profile_view_model.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_view_model_test.mocks.dart';

@GenerateMocks([
  GetProfileUseCase,
  EditProfileUseCase,
  ChangePasswordUseCase,
  UploadPhotoUseCase,
  LogoutUseCase,
])
void main() {
  late ProfileViewModel viewModel;
  late MockGetProfileUseCase mockGetProfileUseCase;
  late MockEditProfileUseCase mockEditProfileUseCase;
  late MockChangePasswordUseCase mockChangePasswordUseCase;
  late MockUploadPhotoUseCase mockUploadPhotoUseCase;
  late MockLogoutUseCase mockLogoutUseCase;

  final tUserEntity = UserEntity(
    id: '1',
    firstName: 'John',
    lastName: 'Doe',
    email: 'john@test.com',
    phone: '+201234567890',
    photoUrl: 'https://example.com/photo.jpg',
    role: 'user',
    gender: 'male',
  );

  final tChangePasswordEntity = ChangePasswordEntity(
    message: 'Password changed successfully',
    token: 'new_token',
  );

  setUp(() {
    provideDummy<BaseResponse<UserEntity>>(SuccessResponse(data: tUserEntity));
    provideDummy<BaseResponse<ChangePasswordEntity>>(
      SuccessResponse(data: tChangePasswordEntity),
    );
    provideDummy<BaseResponse<String>>(SuccessResponse(data: 'success'));

    mockGetProfileUseCase = MockGetProfileUseCase();
    mockEditProfileUseCase = MockEditProfileUseCase();
    mockChangePasswordUseCase = MockChangePasswordUseCase();
    mockUploadPhotoUseCase = MockUploadPhotoUseCase();
    mockLogoutUseCase = MockLogoutUseCase();

    viewModel = ProfileViewModel(
      mockGetProfileUseCase,
      mockEditProfileUseCase,
      mockChangePasswordUseCase,
      mockUploadPhotoUseCase,
      mockLogoutUseCase,
    );
  });

  tearDown(() => viewModel.close());

  group('ProfileViewModel - GetProfile', () {
    test('GetProfile emits [Loading, Success] when usecase succeeds', () async {
      when(
        mockGetProfileUseCase.call(),
      ).thenAnswer((_) async => SuccessResponse(data: tUserEntity));

      final expectedStates = [
        predicate<ProfileState>((s) => s.profileState?.isLoading == true),
        predicate<ProfileState>(
          (s) =>
              s.profileState?.isLoading == false &&
              s.profileState?.data == tUserEntity,
        ),
      ];

      expectLater(viewModel.stream, emitsInOrder(expectedStates));

      viewModel.doIntent(GetProfileEvent());
    });

    test('GetProfile emits [Loading, Error] when usecase fails', () async {
      when(
        mockGetProfileUseCase.call(),
      ).thenAnswer((_) async => ErrorResponse(errorMessage: 'Error'));

      final expectedStates = [
        predicate<ProfileState>((s) => s.profileState?.isLoading == true),
        predicate<ProfileState>(
          (s) =>
              s.profileState?.isLoading == false &&
              s.profileState?.errorMessage == 'Error',
        ),
      ];

      expectLater(viewModel.stream, emitsInOrder(expectedStates));

      viewModel.doIntent(GetProfileEvent());
    });
  });

  group('ProfileViewModel - EditProfile', () {
    test(
      'EditProfile emits [Loading, Success] when usecase succeeds',
      () async {
        final request = EditProfileRequest(
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@test.com',
          phone: '+201234567890',
        );

        when(
          mockEditProfileUseCase.call(any),
        ).thenAnswer((_) async => SuccessResponse(data: tUserEntity));

        final expectedStates = [
          predicate<ProfileState>((s) => s.editProfileState?.isLoading == true),
          predicate<ProfileState>(
            (s) =>
                s.editProfileState?.isLoading == false &&
                s.editProfileState?.data == tUserEntity,
          ),
        ];

        expectLater(viewModel.stream, emitsInOrder(expectedStates));

        viewModel.doIntent(EditProfileEvent(request));
      },
    );

    test('EditProfile emits [Loading, Error] when usecase fails', () async {
      final request = EditProfileRequest(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@test.com',
        phone: '+201234567890',
      );

      when(
        mockEditProfileUseCase.call(any),
      ).thenAnswer((_) async => ErrorResponse(errorMessage: 'Update failed'));

      final expectedStates = [
        predicate<ProfileState>((s) => s.editProfileState?.isLoading == true),
        predicate<ProfileState>(
          (s) =>
              s.editProfileState?.isLoading == false &&
              s.editProfileState?.errorMessage == 'Update failed',
        ),
      ];

      expectLater(viewModel.stream, emitsInOrder(expectedStates));

      viewModel.doIntent(EditProfileEvent(request));
    });
  });

  group('ProfileViewModel - ChangePassword', () {
    test(
      'ChangePassword emits [Loading, Success] when usecase succeeds',
      () async {
        when(
          mockChangePasswordUseCase.call(any, any),
        ).thenAnswer((_) async => SuccessResponse(data: tChangePasswordEntity));

        final expectedStates = [
          predicate<ProfileState>(
            (s) => s.changePasswordState?.isLoading == true,
          ),
          predicate<ProfileState>(
            (s) =>
                s.changePasswordState?.isLoading == false &&
                s.changePasswordState?.data == tChangePasswordEntity,
          ),
        ];

        expectLater(viewModel.stream, emitsInOrder(expectedStates));

        viewModel.doIntent(
          ChangePasswordEvent(oldPassword: 'oldPass', newPassword: 'newPass'),
        );
      },
    );

    test('ChangePassword emits [Loading, Error] when usecase fails', () async {
      when(
        mockChangePasswordUseCase.call(any, any),
      ).thenAnswer((_) async => ErrorResponse(errorMessage: 'Wrong password'));

      final expectedStates = [
        predicate<ProfileState>(
          (s) => s.changePasswordState?.isLoading == true,
        ),
        predicate<ProfileState>(
          (s) =>
              s.changePasswordState?.isLoading == false &&
              s.changePasswordState?.errorMessage == 'Wrong password',
        ),
      ];

      expectLater(viewModel.stream, emitsInOrder(expectedStates));

      viewModel.doIntent(
        ChangePasswordEvent(oldPassword: 'oldPass', newPassword: 'newPass'),
      );
    });
  });

  group('ProfileViewModel - Logout', () {
    test('Logout emits [Loading, Success] when usecase succeeds', () async {
      when(
        mockLogoutUseCase.call(),
      ).thenAnswer((_) async => SuccessResponse(data: 'Logged out'));

      final expectedStates = [
        predicate<ProfileState>((s) => s.logoutState?.isLoading == true),
        predicate<ProfileState>((s) => s.logoutState?.isLoading == false),
      ];

      expectLater(viewModel.stream, emitsInOrder(expectedStates));

      viewModel.doIntent(LogoutEvent());
    });

    test('Logout emits [Loading, Error] when usecase fails', () async {
      when(
        mockLogoutUseCase.call(),
      ).thenAnswer((_) async => ErrorResponse(errorMessage: 'Logout failed'));

      final expectedStates = [
        predicate<ProfileState>((s) => s.logoutState?.isLoading == true),
        predicate<ProfileState>(
          (s) =>
              s.logoutState?.isLoading == false &&
              s.logoutState?.errorMessage == 'Logout failed',
        ),
      ];

      expectLater(viewModel.stream, emitsInOrder(expectedStates));

      viewModel.doIntent(LogoutEvent());
    });
  });

  group('ProfileViewModel - SelectProfileImage', () {
    test('SelectProfileImage updates selectedProfileImage state', () async {
      final testFile = File('test_path.jpg');

      final expectedStates = [
        predicate<ProfileState>((s) => s.selectedProfileImage == testFile),
      ];

      expectLater(viewModel.stream, emitsInOrder(expectedStates));

      viewModel.doIntent(SelectProfileImageEvent(testFile));
    });
  });

  group('ProfileViewModel - UploadPhoto', () {
    test('UploadPhoto emits [Loading, Success] when usecase succeeds', () async {
      final testFile = File('test_image.jpg');
      const successMessage = 'Photo uploaded successfully';

      when(
        mockUploadPhotoUseCase.call(any),
      ).thenAnswer((_) async => SuccessResponse(data: successMessage));

      // After upload success, _getProfile is called, so we need to mock it too
      when(
        mockGetProfileUseCase.call(),
      ).thenAnswer((_) async => SuccessResponse(data: tUserEntity));

      final expectedStates = [
        predicate<ProfileState>((s) => s.uploadPhotoState?.isLoading == true),
        predicate<ProfileState>(
          (s) =>
              s.uploadPhotoState?.isLoading == false &&
              s.uploadPhotoState?.data == successMessage &&
              s.selectedProfileImage == null, // cleared after success
        ),
        // Profile refresh states
        predicate<ProfileState>((s) => s.profileState?.isLoading == true),
        predicate<ProfileState>(
          (s) =>
              s.profileState?.isLoading == false &&
              s.profileState?.data == tUserEntity,
        ),
      ];

      expectLater(viewModel.stream, emitsInOrder(expectedStates));

      viewModel.doIntent(UploadPhotoEvent(testFile));
    });

    test('UploadPhoto emits [Loading, Error] when usecase fails', () async {
      final testFile = File('test_image.jpg');

      when(
        mockUploadPhotoUseCase.call(any),
      ).thenAnswer((_) async => ErrorResponse(errorMessage: 'Upload failed'));

      final expectedStates = [
        predicate<ProfileState>((s) => s.uploadPhotoState?.isLoading == true),
        predicate<ProfileState>(
          (s) =>
              s.uploadPhotoState?.isLoading == false &&
              s.uploadPhotoState?.errorMessage == 'Upload failed',
        ),
      ];

      expectLater(viewModel.stream, emitsInOrder(expectedStates));

      viewModel.doIntent(UploadPhotoEvent(testFile));
    });
  });
}
