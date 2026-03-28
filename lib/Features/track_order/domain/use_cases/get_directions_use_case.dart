import 'package:flowers_app/Features/track_order/data/remote_data_source_contract/map_remote_data_source_contract.dart';
import 'package:injectable/injectable.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapbox;

@injectable
class GetDirectionsUseCase {
  final MapRemoteDataSourceContract _repository;
  GetDirectionsUseCase(this._repository);

  Future<List<mapbox.Position>> call(List<mapbox.Position> points) {
    return _repository.getRoute(points);
  }
}
