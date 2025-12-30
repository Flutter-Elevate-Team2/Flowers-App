import 'package:flowers_app/Features/home/domain/entities/home_entities/home_entity.dart';
import 'package:flowers_app/Features/home/domain/use_cases/get_home_sections_use_case.dart';
import 'package:flowers_app/Features/home/presentation/view_model/home_events.dart';
import 'package:flowers_app/Features/home/presentation/view_model/home_states.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeViewModel extends Cubit<HomeStates> {
  final GetHomeSectionsUseCase _getHomeSectionsUseCase;

  HomeViewModel(this._getHomeSectionsUseCase) : super(HomeStates()) {
     doIntent(GetHomeDataEvent());
  }

  void doIntent(HomeEvent event) {
    switch (event) {
      case GetHomeDataEvent():
        _getHomeData();
        break;
    }
  }

  void _getHomeData() async {
    emit(state.copyWith(homeState: BaseState<HomeEntity>(isLoading: true)));

    final response = await _getHomeSectionsUseCase.call();

    switch (response) {
      case SuccessResponse<HomeEntity>():
        emit(
          state.copyWith(
            homeState: BaseState<HomeEntity>(
              isLoading: false,
              data: response.data,
              errorMessage: null,
            ),
          ),
        );
        break;

      case ErrorResponse<HomeEntity>():
        emit(
          state.copyWith(
            homeState: BaseState<HomeEntity>(
              isLoading: false,
              data: null,
              errorMessage: response.errorMessage,
            ),
          ),
        );
        break;
    }
  }
}
