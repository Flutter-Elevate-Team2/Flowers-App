import 'package:flowers_app/Features/home/data/data_source_contract/home_remote_data_source_contract.dart';
import 'package:flowers_app/Features/home/data/models/home_response/home_response.dart';
import 'package:flowers_app/Features/home/data/repo/home_repo_imple.dart';
import 'package:flowers_app/Features/home/domain/entities/home_entities/home_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_repo_imple_test.mocks.dart';

@GenerateMocks([HomeRemoteDataSourceContract])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  provideDummy<BaseResponse<HomeEntity>>(
    SuccessResponse(
      data: HomeEntity(
        products: [],
        categories: [],
        bestSellers: [],
        occasions: [],
      ),
    ),
  );
  late HomeRepoImple repo;
  late MockHomeRemoteDataSourceContract mockDataSource;

  setUp(() {
    mockDataSource = MockHomeRemoteDataSourceContract();
    repo = HomeRepoImple(mockDataSource);
  });

  group('HomeRepoImple Tests', () {
    test(
      'getHomeSections should return SuccessResponse holding HomeEntity on success',
      () async {
        // Arrange
        final homeResponse = HomeResponse(
          products: [],
          categories: [],
          bestSeller: [],
          occasions: [],
        );
        when(
          mockDataSource.getHomeSections(),
        ).thenAnswer((_) async => homeResponse);

        // Act
        final result = await repo.getHomeSections();

        // Assert
        expect(result, isA<SuccessResponse<HomeEntity>>());
        expect((result as SuccessResponse<HomeEntity>).data, isA<HomeEntity>());
        verify(mockDataSource.getHomeSections()).called(1);
      },
    );

    test('getHomeSections should return ErrorResponse on failure', () async {
      // Arrange
      when(
        mockDataSource.getHomeSections(),
      ).thenThrow(Exception('Generic error'));

      // Act
      final result = await repo.getHomeSections();

      // Assert
      expect(result, isA<ErrorResponse<HomeEntity>>());
      verify(mockDataSource.getHomeSections()).called(1);
    });
  });
}
