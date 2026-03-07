import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://api.mapbox.com/")
@injectable
abstract class MapboxApiClient {
  @factoryMethod
  factory MapboxApiClient(Dio dio) = _MapboxApiClient;

  @GET("directions/v5/mapbox/driving/{coordinates}")
  Future<dynamic> getDirections(
    @Path("coordinates") String coordinates,
    @Query("geometries") String geometries,
    @Query("overview") String overview,
    @Query("access_token") String accessToken,
  );
}
