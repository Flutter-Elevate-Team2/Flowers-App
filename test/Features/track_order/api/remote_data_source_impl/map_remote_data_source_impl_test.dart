import 'package:flowers_app/Features/track_order/api/api_client/api_client.dart';
import 'package:flowers_app/Features/track_order/api/remote_data_source_impl/map_remote_data_source_impl.dart';
 import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapbox;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'map_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([MapboxApiClient])
void main() {
  late MapRemoteDataSourceImpl dataSource;
  late MockMapboxApiClient mockApiClient;

  setUp(() async {
  await dotenv.load(mergeWith: {'MAPBOX_ACCESS_TOKEN': 'test_token'});

    mockApiClient = MockMapboxApiClient();
    dataSource = MapRemoteDataSourceImpl(mockApiClient);
  });

  group('MapRemoteDataSourceImpl Tests', () {
    final tPositions = [
      mapbox.Position(31.2357, 30.0444),
      mapbox.Position(31.2585, 30.0511),
    ];

    test(
      'should return list of positions when getDirections is successful',
          () async {
        // Arrange
        final tResponse = {
          'routes': [
            {
              'geometry': {
                'coordinates': [
                  [31.2357, 30.0444],
                  [31.2400, 30.0450],
                  [31.2585, 30.0511],
                ],
              },
            }
          ],
        };

        when(mockApiClient.getDirections(any, any, any, any))
            .thenAnswer((_) async => tResponse);

        // Act
        final result = await dataSource.getRoute(tPositions);

        // Assert
        expect(result, isA<List<mapbox.Position>>());
        expect(result.length, 3);
        expect(result[0].lng, 31.2357);

        verify(mockApiClient.getDirections(
          "31.2357,30.0444;31.2585,30.0511",
          "geojson",
          "full",
          "test_token",
        )).called(1);
      },
    );

    test('should return empty list when response has no routes', () async {
      // Arrange
      when(mockApiClient.getDirections(any, any, any, any))
          .thenAnswer((_) async => {'routes': []});

      // Act
      final result = await dataSource.getRoute(tPositions);

      // Assert
      expect(result, isEmpty);
    });
  });
}