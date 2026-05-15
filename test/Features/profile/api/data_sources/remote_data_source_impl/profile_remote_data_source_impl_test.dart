import 'dart:io';
import 'package:flowers_app/Features/profile/api/data_sources/remote_data_source_impl/profile_remote_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowers_app/Features/profile/api/api_client/profile_api_client.dart';
 import 'package:flowers_app/Features/profile/data/models/change_password_request.dart';
import 'package:flowers_app/Features/profile/data/models/change_password_response.dart';
import 'package:flowers_app/Features/profile/data/models/edit_profile_request.dart';
import 'package:flowers_app/Features/profile/data/models/logout_response.dart';
import 'package:flowers_app/Features/profile/data/models/profile_dto.dart';
import 'package:flowers_app/Features/profile/data/models/upload_photo_response.dart';

import 'profile_remote_data_source_impl_test.mocks.dart';
@GenerateMocks([ProfileApi])

void main() {
  late ProfileRemoteDataSourceImpl dataSource;
  late MockProfileApi mockProfileApi;

  setUp(() {
    mockProfileApi = MockProfileApi();
    dataSource = ProfileRemoteDataSourceImpl(mockProfileApi);
  });

  group('ProfileRemoteDataSource Tests', () {

    test('getProfile should return ProfileDto when the call is successful', () async {
      // Arrange
      final tProfileDto = ProfileDto(); // افترضنا وجود كائن جاهز
      when(mockProfileApi.getProfile()).thenAnswer((_) async => tProfileDto);

      // Act
      final result = await dataSource.getProfile();

      // Assert
      expect(result, equals(tProfileDto));
      verify(mockProfileApi.getProfile()).called(1);
    });

    test('editProfile should return updated ProfileDto', () async {
      // Arrange
      final tRequest = EditProfileRequest(firstName: "Test Name");
      final tResponse = ProfileDto();
      when(mockProfileApi.editProfile(tRequest)).thenAnswer((_) async => tResponse);

      // Act
      final result = await dataSource.editProfile(tRequest);

      // Assert
      expect(result, equals(tResponse));
      verify(mockProfileApi.editProfile(tRequest)).called(1);
    });

    test('uploadPhoto should return UploadPhotoResponse', () async {
      // Arrange
      final tFile = File('path/to/image.png');
      final tResponse = UploadPhotoResponse(message: '');
      when(mockProfileApi.uploadPhoto(tFile)).thenAnswer((_) async => tResponse);

      // Act
      final result = await dataSource.uploadPhoto(tFile);

      // Assert
      expect(result, equals(tResponse));
      verify(mockProfileApi.uploadPhoto(tFile)).called(1);
    });

    test('changePassword should return ChangePasswordResponse', () async {
      // Arrange
      final tRequest = ChangePasswordRequest( newPassword: "456", password: '123');
      final tResponse = ChangePasswordResponse(message: '');
      when(mockProfileApi.changePassword(tRequest)).thenAnswer((_) async => tResponse);

      // Act
      final result = await dataSource.changePassword(tRequest);

      // Assert
      expect(result, equals(tResponse));
      verify(mockProfileApi.changePassword(tRequest)).called(1);
    });

    test('logout should return LogoutResponse', () async {
      // Arrange
      final tResponse = LogoutResponse(message: '');
      when(mockProfileApi.logout()).thenAnswer((_) async => tResponse);

      // Act
      final result = await dataSource.logout();

      // Assert
      expect(result, equals(tResponse));
      verify(mockProfileApi.logout()).called(1);
    });

    test('should throw an exception when the api call fails', () async {
      // Arrange
      when(mockProfileApi.getProfile()).thenThrow(Exception('Server Error'));

      // Act
      final call = dataSource.getProfile;

      // Assert
      expect(() => call(), throwsException);
    });
  });
}