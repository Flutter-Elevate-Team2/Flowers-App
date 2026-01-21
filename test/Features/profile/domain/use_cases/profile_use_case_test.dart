import 'package:flowers_app/Features/profile/domain/entities/user_entity.dart';
import 'package:flowers_app/Features/profile/domain/repo/profile_repo_contract.dart';
import 'package:flowers_app/Features/profile/domain/use_cases/profile_use_case.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_use_case_test.mocks.dart';

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
  late GetProfileUseCase useCase;
  late MockProfileRepoContract mockRepo;

  setUp(() {
    mockRepo = MockProfileRepoContract();
    useCase = GetProfileUseCase(mockRepo);
  });

  group('ProfileUseCase Tests', () {
    test('call should return SuccessResponse from repository', () async {
      // Arrange
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

      when(mockRepo.getProfileData()).thenAnswer((_) async => successResponse);

      // Act
      final result = await useCase.call();

      // Assert
      expect(result, successResponse);
      expect(result, isA<SuccessResponse<UserEntity>>());
      verify(mockRepo.getProfileData()).called(1);
    });

    test('call should return ErrorResponse when repository fails', () async {
      // Arrange
      const errorMessage = 'Failed to fetch profile';
      final errorResponse = ErrorResponse<UserEntity>(
        errorMessage: errorMessage,
      );

      when(mockRepo.getProfileData()).thenAnswer((_) async => errorResponse);

      // Act
      final result = await useCase.call();

      // Assert
      expect(result, errorResponse);
      expect(result, isA<ErrorResponse<UserEntity>>());
      verify(mockRepo.getProfileData()).called(1);
    });
  });
}
