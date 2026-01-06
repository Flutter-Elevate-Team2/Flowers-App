import 'package:flowers_app/Features/commerce/domain/entities/home_entities/home_entity.dart';
import 'package:flowers_app/Features/commerce/domain/repos/commerce_repo_contract.dart';
import 'package:flowers_app/Features/commerce/domain/use_cases/get_home_sections_use_case.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_home_sections_use_case_test.mocks.dart';

@GenerateMocks([CommerceRepoContract])
void main() {
  provideDummy<BaseResponse<HomeEntity>>(
    SuccessResponse(
      data: HomeEntity(categories: [], bestSellers: [], occasions: []),
    ),
  );
  late GetHomeSectionsUseCase useCase;
  late MockCommerceRepoContract mockRepo;

  setUp(() {
    mockRepo = MockCommerceRepoContract();
    useCase = GetHomeSectionsUseCase(mockRepo);
  });

  group('GetHomeSectionsUseCase Tests', () {
    test('call should return SuccessResponse from repository', () async {
      // Arrange
      final homeEntity = HomeEntity(
        categories: [],
        bestSellers: [],
        occasions: [],
      );
      final successResponse = SuccessResponse<HomeEntity>(data: homeEntity);
      when(mockRepo.getHomeSections()).thenAnswer((_) async => successResponse);

      // Act
      final result = await useCase.call();

      // Assert
      expect(result, successResponse);
      expect(result, isA<SuccessResponse<HomeEntity>>());
      expect((result as SuccessResponse<HomeEntity>).data, homeEntity);
      verify(mockRepo.getHomeSections()).called(1);
    });

    test('call should return ErrorResponse when repository fails', () async {
      // Arrange
      const errorMessage = 'Failed to fetch home sections';
      final errorResponse = ErrorResponse<HomeEntity>(
        errorMessage: errorMessage,
      );
      when(mockRepo.getHomeSections()).thenAnswer((_) async => errorResponse);

      // Act
      final result = await useCase.call();

      // Assert
      expect(result, errorResponse);
      expect(result, isA<ErrorResponse<HomeEntity>>());
      expect((result as ErrorResponse<HomeEntity>).errorMessage, errorMessage);
      verify(mockRepo.getHomeSections()).called(1);
    });
  });
}
