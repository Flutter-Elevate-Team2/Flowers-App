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
import 'package:flowers_app/Features/profile/presentation/view_model/profile_view_model.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/controller/session_controller.dart';
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
  HasValidTokenUseCase,
  SessionController
])
void main() {
  late ProfileViewModel viewModel;
  late MockGetProfileUseCase mockGetProfileUseCase;
  late MockEditProfileUseCase mockEditProfileUseCase;
  late MockChangePasswordUseCase mockChangePasswordUseCase;
  late MockUploadPhotoUseCase mockUploadPhotoUseCase;
  late MockLogoutUseCase mockLogoutUseCase;
  late MockHasValidTokenUseCase mockHasTokenUseCase;
  late MockSessionController mockSessionController;

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
    mockHasTokenUseCase = MockHasValidTokenUseCase();
    mockSessionController = MockSessionController();

    when(mockSessionController.onLogin)
        .thenAnswer((_) => const Stream.empty());
    when(mockSessionController.onLogout)
        .thenAnswer((_) => const Stream.empty());

    viewModel = ProfileViewModel(
      mockGetProfileUseCase,
      mockEditProfileUseCase,
      mockChangePasswordUseCase,
      mockUploadPhotoUseCase,
      mockLogoutUseCase,
      mockHasTokenUseCase,
      mockSessionController,
    );
  });

  tearDown(() => viewModel.close());

  group('ProfileViewModel - GetProfile (New Guest Mode Logic)', () {
    test(
      'GetProfile emits empty ProfileState when user is Guest',
          () async {
        // Arrange
        when(mockHasTokenUseCase.call()).thenAnswer((_) async => false);

        // Assert
        expectLater(
          viewModel.stream,
          emits(
            predicate<ProfileState>(
                  (s) => s.profileState == null,
            ),
          ),
        );

        // Act
        viewModel.doIntent(GetProfileEvent());

        verifyNever(mockGetProfileUseCase.call());
      },
    );

    test(
      'GetProfile emits [Loading, Success] when user is LoggedIn and usecase succeeds',
      () async {
        when(mockHasTokenUseCase.call()).thenAnswer((_) async => true);
        when(
          mockGetProfileUseCase.call(),
        ).thenAnswer((_) async => SuccessResponse(data: tUserEntity));

        final expectedStates = [
          predicate<ProfileState>((s) => s.profileState?.isLoading == true),
          predicate<ProfileState>((s) => s.profileState?.data == tUserEntity),
        ];

        expectLater(viewModel.stream, emitsInOrder(expectedStates));

        viewModel.doIntent(GetProfileEvent());
      },
    );
  });

  group('ProfileViewModel - EditProfile', () {
    test(
      'EditProfile emits [Loading, Success] when usecase succeeds',
      () async {
        final request = EditProfileRequest(
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@test.com',
          phone: '123',
        );

        when(
          mockEditProfileUseCase.call(any),
        ).thenAnswer((_) async => SuccessResponse(data: tUserEntity));

        expectLater(
          viewModel.stream,
          emitsInOrder([
            predicate<ProfileState>(
              (s) => s.editProfileState?.isLoading == true,
            ),
            predicate<ProfileState>(
              (s) =>
                  s.editProfileState?.isLoading == false &&
                  s.editProfileState?.data == tUserEntity &&
                  s.profileState?.data == tUserEntity,
            ),
          ]),
        );

        viewModel.doIntent(EditProfileEvent(request));
      },
    );
  });

  group('ProfileViewModel - UploadPhoto', () {
    test(
      'UploadPhoto emits [Loading, Success] and refreshes profile',
      () async {
        final testFile = File('test.jpg');

        when(mockHasTokenUseCase.call()).thenAnswer((_) async => true);
        when(
          mockUploadPhotoUseCase.call(any),
        ).thenAnswer((_) async => SuccessResponse(data: 'Uploaded'));
        when(
          mockGetProfileUseCase.call(),
        ).thenAnswer((_) async => SuccessResponse(data: tUserEntity));

        final expectedStates = [
          predicate<ProfileState>((s) => s.uploadPhotoState?.isLoading == true),
          predicate<ProfileState>(
            (s) =>
                s.uploadPhotoState?.isLoading == false &&
                s.selectedProfileImage == null,
          ),
          predicate<ProfileState>((s) => s.profileState?.isLoading == true),
          predicate<ProfileState>((s) => s.profileState?.data == tUserEntity),
        ];

        expectLater(viewModel.stream, emitsInOrder(expectedStates));
        viewModel.doIntent(UploadPhotoEvent(testFile));
      },
    );
  });
  group('ProfileViewModel - ChangePassword', () {
    test(
      'ChangePassword emits [Loading, Success] when usecase succeeds',
          () async {
        when(mockChangePasswordUseCase.call(any, any)).thenAnswer(
              (_) async => SuccessResponse(data: tChangePasswordEntity),
        );

        final expectedStates = [
          predicate<ProfileState>((s) => s.changePasswordState?.isLoading == true),
          predicate<ProfileState>(
                (s) =>
            s.changePasswordState?.isLoading == false &&
                s.changePasswordState?.data == tChangePasswordEntity,
          ),
        ];

        expectLater(viewModel.stream, emitsInOrder(expectedStates));

        viewModel.doIntent(
          ChangePasswordEvent(oldPassword: '123', newPassword: '456'),
        );
      },
    );

    test(
      'ChangePassword emits [Loading, Error] when usecase fails',
          () async {
        when(mockChangePasswordUseCase.call(any, any)).thenAnswer(
              (_) async => ErrorResponse(errorMessage: 'Invalid old password'),
        );

        final expectedStates = [
          predicate<ProfileState>((s) => s.changePasswordState?.isLoading == true),
          predicate<ProfileState>(
                (s) =>
            s.changePasswordState?.isLoading == false &&
                s.changePasswordState?.errorMessage == 'Invalid old password',
          ),
        ];

        expectLater(viewModel.stream, emitsInOrder(expectedStates));

        viewModel.doIntent(
          ChangePasswordEvent(oldPassword: 'wrong', newPassword: '456'),
        );
      },
    );
    group('ProfileViewModel - Logout', () {
      test(
        'Logout emits [Loading, Success] when usecase succeeds',
            () async {
          when(mockLogoutUseCase.call())
              .thenAnswer((_) async => SuccessResponse(data: 'Logged out'));

          final expectedStates = [
            predicate<ProfileState>((s) => s.logoutState?.isLoading == true),
            predicate<ProfileState>((s) => s.logoutState?.isLoading == false),
          ];

          expectLater(viewModel.stream, emitsInOrder(expectedStates));

          viewModel.doIntent(LogoutEvent());
        },
      );
    });

    group('ProfileViewModel - Selection Logic', () {
      test(
        'SelectProfileImage updates selectedProfileImage in state',
            () async {
          final testFile = File('image.jpg');

          expectLater(
            viewModel.stream,
            emits(
              predicate<ProfileState>(
                    (s) => s.selectedProfileImage?.path == testFile.path,
              ),
            ),
          );

          viewModel.doIntent(SelectProfileImageEvent(testFile));
        },
      );
    });

    group('ProfileViewModel - Error Responses', () {
      test(
        'GetProfile emits [Loading, Error] when usecase fails',
            () async {
          when(mockHasTokenUseCase.call()).thenAnswer((_) async => true);
          when(mockGetProfileUseCase.call()).thenAnswer(
                (_) async => ErrorResponse(errorMessage: 'Server Error'),
          );

          final expectedStates = [
            predicate<ProfileState>((s) => s.profileState?.isLoading == true),
            predicate<ProfileState>(
                  (s) =>
              s.profileState?.isLoading == false &&
                  s.profileState?.errorMessage == 'Server Error',
            ),
          ];

          expectLater(viewModel.stream, emitsInOrder(expectedStates));

          viewModel.doIntent(GetProfileEvent());
        },
      );
    });
  });
}
