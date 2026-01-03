import 'package:flowers_app/Features/home/domain/entities/home_entities/home_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';

abstract class HomeRepoContract {
  Future<BaseResponse<HomeEntity>>getHomeSections();
}