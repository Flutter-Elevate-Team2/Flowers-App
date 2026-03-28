import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapbox;

abstract class MapRemoteDataSourceContract {
  Future<List<mapbox.Position>> getRoute(
      List<mapbox.Position> points,
  );
}
