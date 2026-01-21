import 'dart:io';

import 'package:flowers_app/Features/profile/data/data_sources/remote_data_source_contract/profile_remote_data_source_contract.dart';
import 'package:flowers_app/Features/profile/data/models/change_password_request.dart';
import 'package:flowers_app/Features/profile/data/models/change_password_response.dart';
import 'package:flowers_app/Features/profile/data/models/edit_profile_request.dart';
import 'package:flowers_app/Features/profile/data/models/logout_response.dart';
import 'package:flowers_app/Features/profile/data/models/profile_dto.dart';
import 'package:flowers_app/Features/profile/data/models/upload_photo_response.dart';
import 'package:flowers_app/Features/profile/data/models/user_model.dart';
import 'package:flowers_app/Features/profile/data/repo/profile_repo_imple.dart';
import 'package:flowers_app/Features/profile/domain/entities/change_password_entity.dart';
import 'package:flowers_app/Features/profile/domain/entities/user_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_repo_impl_test.mocks.dart';

@GenerateMocks([ProfileRemoteDataSourceContract])
void main() {
  late ProfileRepoImpl repo;
  late MockProfileRemoteDataSourceContract mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockProfileRemoteDataSourceContract();
    repo = ProfileRepoImpl(mockRemoteDataSource);
  });

  group('ProfileRepoImpl Tests', () {
    group('getProfileData', () {
      test(
        'should return SuccessResponse with UserEntity when remote call succeeds',
        () async {
          // Arrange
          final userModel = UserModel(
            id: '1',
            firstName: 'John',
            lastName: 'Doe',
            email: 'john@example.com',
            phone: '1234567890',
            photo: 'url',
            role: 'user',
            gender: 'Male',
          );
          final profileDto = ProfileDto(message: 'Success', user: userModel);

          when(
            mockRemoteDataSource.getProfile(),
          ).thenAnswer((_) async => profileDto);

          // Act
          final result = await repo.getProfileData();

          // Assert
          expect(result, isA<SuccessResponse<UserEntity>>());
          final data = (result as SuccessResponse<UserEntity>).data;
          expect(data.firstName, 'John');
          expect(data.email, 'john@example.com');
          verify(mockRemoteDataSource.getProfile()).called(1);
        },
      );

      test('should return ErrorResponse when remote call fails', () async {
        // Arrange
        final exception = Exception('Failed');
        when(mockRemoteDataSource.getProfile()).thenThrow(exception);

        // Act
        final result = await repo.getProfileData();

        // Assert
        expect(result, isA<ErrorResponse<UserEntity>>());
        verify(mockRemoteDataSource.getProfile()).called(1);
      });
    });

    group('editProfile', () {
      test(
        'should return SuccessResponse with UserEntity when remote call succeeds',
        () async {
          // Arrange
          final request = EditProfileRequest(
            firstName: 'John',
            lastName: 'Doe',
            phone: '1234567890',
            gender: 'Male',
          );
          final userModel = UserModel(
            id: '1',
            firstName: 'John',
            lastName: 'Doe',
          );
          final profileDto = ProfileDto(message: 'Updated', user: userModel);

          when(
            mockRemoteDataSource.editProfile(request),
          ).thenAnswer((_) async => profileDto);

          // Act
          final result = await repo.editProfile(request);

          // Assert
          expect(result, isA<SuccessResponse<UserEntity>>());
          verify(mockRemoteDataSource.editProfile(request)).called(1);
        },
      );
    });

    group('uploadPhoto', () {
      test(
        'should return SuccessResponse with message when remote call succeeds',
        () async {
          // Arrange
          final file = File('path/to/file');
          final response = UploadPhotoResponse(message: 'Uploaded');

          when(
            mockRemoteDataSource.uploadPhoto(file),
          ).thenAnswer((_) async => response);

          // Act
          final result = await repo.uploadPhoto(file);

          // Assert
          expect(result, isA<SuccessResponse<String>>());
          expect((result as SuccessResponse).data, 'Uploaded');
          verify(mockRemoteDataSource.uploadPhoto(file)).called(1);
        },
      );
    });

    group('changePassword', () {
      test(
        'should return SuccessResponse with ChangePasswordEntity when remote call succeeds',
        () async {
          // Arrange
          final request = ChangePasswordRequest(
            password: 'old',
            newPassword: 'new',
          );
          final response = ChangePasswordResponse(
            message: 'Changed',
            token: 'token',
          );

          when(
            mockRemoteDataSource.changePassword(request),
          ).thenAnswer((_) async => response);

          // Act
          final result = await repo.changePassword(request);

          // Assert
          expect(result, isA<SuccessResponse<ChangePasswordEntity>>());
          final data = (result as SuccessResponse<ChangePasswordEntity>).data;
          expect(data.message, 'Changed');
          expect(data.token, 'token');
          verify(mockRemoteDataSource.changePassword(request)).called(1);
        },
      );
    });

    group('logout', () {
      test(
        'should return SuccessResponse with message when remote call succeeds',
        () async {
          // Arrange
          final response = LogoutResponse(message: 'Logged out');

          when(mockRemoteDataSource.logout()).thenAnswer((_) async => response);

          // Act
          final result = await repo.logout();

          // Assert
          expect(result, isA<SuccessResponse<String>>());
          expect((result as SuccessResponse).data, 'Logged out');
          verify(mockRemoteDataSource.logout()).called(1);
        },
      );
    });
  });
}
