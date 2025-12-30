import 'package:flowers_app/Features/home/domain/entities/home_entities/home_entity.dart';
import 'package:flowers_app/Features/home/domain/repo/home_repo_contract.dart';
import 'package:flowers_app/Features/home/domain/use_cases/get_home_sections_use_case.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_home_sections_use_case_test.mocks.dart';

@GenerateMocks([HomeRepoContract])
void main() {
  provideDummy<BaseResponse<HomeEntity>>(
    SuccessResponse(
      data: HomeEntity(
        categories: [],
        bestSellers: [],
        occasions: [],
      ),
    ),
  );
  late GetHomeSectionsUseCase useCase;
  late MockHomeRepoContract mockRepo;

  setUp(() {
    mockRepo = MockHomeRepoContract();
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
  });
}
