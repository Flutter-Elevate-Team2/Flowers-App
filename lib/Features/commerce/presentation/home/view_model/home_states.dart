import 'package:flowers_app/Features/commerce/domain/entities/home_entities/home_entity.dart';
import 'package:flowers_app/core/base_states/base_states.dart';

class HomeStates {
  final BaseState<HomeEntity>? homeState;

  HomeStates({this.homeState});

  HomeStates copyWith({
    BaseState<HomeEntity>? homeState,
  }) {
    return HomeStates(
      homeState: homeState ?? this.homeState,
    );
  }
}
