import 'package:flowers_app/Features/commerce/home/data/models/home_response/home_response.dart';

abstract class HomeRemoteDataSourceContract {
  Future<HomeResponse> getHomeSections();
}
