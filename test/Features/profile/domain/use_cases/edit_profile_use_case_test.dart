import 'package:flowers_app/Features/profile/data/models/edit_profile_request.dart';
import 'package:flowers_app/Features/profile/domain/entities/user_entity.dart';
import 'package:flowers_app/Features/profile/domain/repo/profile_repo_contract.dart';
import 'package:flowers_app/Features/profile/domain/use_cases/edit_profile_use_case.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_use_case_test.mocks.dart';

@GenerateMocks([ProfileRepoContract])
void main() {
  provideDummy<BaseResponse<UserEntity>>(
    SuccessResponse(
      data: UserEntity(
        id: '',
        firstName: '',
        lastName: '',
        email: '',
        phone: '',
        photoUrl: '',
        role: '',
        gender: '',
      ),
    ),
  );
  late EditProfileUseCase useCase;
  late MockProfileRepoContract mockRepo;

  setUp(() {
    mockRepo = MockProfileRepoContract();
    useCase = EditProfileUseCase(mockRepo);
  });

  group('EditProfileUseCase Tests', () {
    test('call should return SuccessResponse from repository', () async {
      // Arrange
      final request = EditProfileRequest(
        firstName: 'John',
        lastName: 'Doe',
        phone: '1234567890',
        gender: 'Male',
      );
      final userEntity = UserEntity(
        id: '1',
        firstName: 'John',
        lastName: 'Doe',
        email: 'test@example.com',
        phone: '1234567890',
        photoUrl: 'url',
        role: 'user',
        gender: 'Male',
      );
      final successResponse = SuccessResponse<UserEntity>(data: userEntity);

      when(mockRepo.editProfile(any)).thenAnswer((_) async => successResponse);

      // Act
      final result = await useCase.call(request);

      // Assert
      expect(result, successResponse);
      expect(result, isA<SuccessResponse<UserEntity>>());
      verify(mockRepo.editProfile(request)).called(1);
    });

    test('call should return ErrorResponse when repository fails', () async {
      // Arrange
      final request = EditProfileRequest(
        firstName: 'John',
        lastName: 'Doe',
        phone: '1234567890',
        gender: 'Male',
      );
      const errorMessage = 'Failed to edit profile';
      final errorResponse = ErrorResponse<UserEntity>(
        errorMessage: errorMessage,
      );

      when(mockRepo.editProfile(any)).thenAnswer((_) async => errorResponse);

      // Act
      final result = await useCase.call(request);

      // Assert
      expect(result, errorResponse);
      expect(result, isA<ErrorResponse<UserEntity>>());
      verify(mockRepo.editProfile(request)).called(1);
    });
  });
}
