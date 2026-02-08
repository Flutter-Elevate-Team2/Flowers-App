import 'dart:io';

import 'package:flowers_app/Features/profile/api/api_client/profile_api_client.dart';
import 'package:flowers_app/Features/profile/api/data_sources/remote_data_source_impl/profile_remote_data_source_impl.dart';
import 'package:flowers_app/Features/profile/data/models/change_password_request.dart';
import 'package:flowers_app/Features/profile/data/models/change_password_response.dart';
import 'package:flowers_app/Features/profile/data/models/edit_profile_request.dart';
import 'package:flowers_app/Features/profile/data/models/logout_response.dart';
import 'package:flowers_app/Features/profile/data/models/profile_dto.dart';
import 'package:flowers_app/Features/profile/data/models/upload_photo_response.dart';
import 'package:flowers_app/Features/profile/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ProfileApi])
void main() {
  late ProfileRemoteDataSourceImpl dataSource;
  late MockProfileApi mockProfileApi;

  setUp(() {
    mockProfileApi = MockProfileApi();
    dataSource = ProfileRemoteDataSourceImpl(mockProfileApi);
  });

  group('ProfileRemoteDataSourceImpl Tests', () {
    test('getProfile should return ProfileDto from API', () async {
      // Arrange
      final userModel = UserModel(id: '1', firstName: 'John', lastName: 'Doe');
      final profileDto = ProfileDto(message: 'Success', user: userModel);
      when(mockProfileApi.getProfile()).thenAnswer((_) async => profileDto);

      // Act
      final result = await dataSource.getProfile();

      // Assert
      expect(result, profileDto);
      verify(mockProfileApi.getProfile()).called(1);
    });

    test('editProfile should return ProfileDto from API', () async {
      // Arrange
      final request = EditProfileRequest(
        firstName: 'John',
        lastName: 'Doe',
        phone: '123',
        gender: 'Male',
      );
      final userModel = UserModel(id: '1', firstName: 'John', lastName: 'Doe');
      final profileDto = ProfileDto(message: 'Updated', user: userModel);

      when(
        mockProfileApi.editProfile(request),
      ).thenAnswer((_) async => profileDto);

      // Act
      final result = await dataSource.editProfile(request);

      // Assert
      expect(result, profileDto);
      verify(mockProfileApi.editProfile(request)).called(1);
    });

    test('uploadPhoto should return UploadPhotoResponse from API', () async {
      // Arrange
      final file = File('path/to/file');
      final response = UploadPhotoResponse(message: 'Uploaded');
      when(mockProfileApi.uploadPhoto(file)).thenAnswer((_) async => response);

      // Act
      final result = await dataSource.uploadPhoto(file);

      // Assert
      expect(result, response);
      verify(mockProfileApi.uploadPhoto(file)).called(1);
    });

    test(
      'changePassword should return ChangePasswordResponse from API',
      () async {
        // Arrange
        final request = ChangePasswordRequest(
          password: 'old',
          newPassword: 'new',
        );
        final response = ChangePasswordResponse(message: 'Changed');
        when(
          mockProfileApi.changePassword(request),
        ).thenAnswer((_) async => response);

        // Act
        final result = await dataSource.changePassword(request);

        // Assert
        expect(result, response);
        verify(mockProfileApi.changePassword(request)).called(1);
      },
    );

    test('logout should return LogoutResponse from API', () async {
      // Arrange
      final response = LogoutResponse(message: 'Logged out');
      when(mockProfileApi.logout()).thenAnswer((_) async => response);

      // Act
      final result = await dataSource.logout();

      // Assert
      expect(result, response);
      verify(mockProfileApi.logout()).called(1);
    });
  });
}
