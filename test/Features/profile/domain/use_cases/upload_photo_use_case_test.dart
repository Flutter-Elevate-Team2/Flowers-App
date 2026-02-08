import 'dart:io';

import 'package:flowers_app/Features/profile/domain/repo/profile_repo_contract.dart';
import 'package:flowers_app/Features/profile/domain/use_cases/upload_photo_use_case.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'upload_photo_use_case_test.mocks.dart';

@GenerateMocks([ProfileRepoContract])
void main() {
  provideDummy<BaseResponse<String>>(SuccessResponse(data: ''));
  late UploadPhotoUseCase useCase;
  late MockProfileRepoContract mockRepo;

  setUp(() {
    mockRepo = MockProfileRepoContract();
    useCase = UploadPhotoUseCase(mockRepo);
  });

  group('UploadPhotoUseCase Tests', () {
    test('call should return SuccessResponse from repository', () async {
      // Arrange
      final file = File('path/to/file');
      const successMessage = 'Photo uploaded successfully';
      final successResponse = SuccessResponse<String>(data: successMessage);

      when(mockRepo.uploadPhoto(any)).thenAnswer((_) async => successResponse);

      // Act
      final result = await useCase.call(file);

      // Assert
      expect(result, successResponse);
      expect(result, isA<SuccessResponse<String>>());
      verify(mockRepo.uploadPhoto(file)).called(1);
    });

    test('call should return ErrorResponse when repository fails', () async {
      // Arrange
      final file = File('path/to/file');
      const errorMessage = 'Failed to upload photo';
      final errorResponse = ErrorResponse<String>(errorMessage: errorMessage);

      when(mockRepo.uploadPhoto(any)).thenAnswer((_) async => errorResponse);

      // Act
      final result = await useCase.call(file);

      // Assert
      expect(result, errorResponse);
      expect(result, isA<ErrorResponse<String>>());
      verify(mockRepo.uploadPhoto(file)).called(1);
    });
  });
}
