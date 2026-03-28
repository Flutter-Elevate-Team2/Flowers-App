import 'package:flowers_app/Features/track_order/api/api_client/api_client.dart';
import 'package:flowers_app/Features/track_order/data/remote_data_source_contract/map_remote_data_source_contract.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapbox;

@Injectable(as: MapRemoteDataSourceContract)
class MapRemoteDataSourceImpl implements MapRemoteDataSourceContract {
  final MapboxApiClient _apiClient;

  MapRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<mapbox.Position>> getRoute(
      List<mapbox.Position> points,
      ) async {
    final String coordinates = points
        .map((p) => "${p.lng},${p.lat}")
        .join(";");

    final String token = dotenv.env['MAPBOX_ACCESS_TOKEN'] ?? '';

    final response = await _apiClient.getDirections(
      coordinates,
      "geojson",
      "full",
      token,
    );
    if (response['routes'] == null || (response['routes'] as List).isEmpty) {
      return [];
    }
    final List coordinatesList =
        response['routes'][0]['geometry']['coordinates'];
    return coordinatesList.map((p) => mapbox.Position(p[0], p[1])).toList();
  }
}
