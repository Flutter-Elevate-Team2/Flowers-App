import 'package:flowers_app/Features/commerce/home/api/api_client/home_api.dart';
import 'package:flowers_app/Features/commerce/home/api/data_source_imple/home_remote_data_source.dart';
import 'package:flowers_app/Features/commerce/home/data/models/home_response/home_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_remote_data_source_test.mocks.dart';

@GenerateMocks([HomeApi])
void main() {
  late HomeRemoteDataSource dataSource;
  late MockHomeApi mockHomeApi;

  setUp(() {
    mockHomeApi = MockHomeApi();
    dataSource = HomeRemoteDataSource(mockHomeApi);
  });

  group('HomeRemoteDataSource Tests', () {
    test('getHomeSections should call getHomeSections on HomeApi', () async {
      // Arrange
      final homeResponse = HomeResponse(
        categories: [],
        bestSeller: [],
        occasions: [],
      );
      when(mockHomeApi.getHomeSections()).thenAnswer((_) async => homeResponse);

      // Act
      final result = await dataSource.getHomeSections();

      // Assert
      expect(result, homeResponse);
      verify(mockHomeApi.getHomeSections()).called(1);
    });

    test(
      'getHomeSections should throw an exception when HomeApi fails',
      () async {
        // Arrange
        when(mockHomeApi.getHomeSections()).thenThrow(Exception('API error'));

        // Act & Assert
        expect(() => dataSource.getHomeSections(), throwsException);
        verify(mockHomeApi.getHomeSections()).called(1);
      },
    );
  });
}
