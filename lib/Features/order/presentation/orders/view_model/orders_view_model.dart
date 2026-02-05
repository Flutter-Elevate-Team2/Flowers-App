import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_entity.dart';
import 'package:flowers_app/Features/order/domain/use_cases/get_user_orders.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_event.dart';
import 'package:flowers_app/Features/order/presentation/orders/view_model/orders_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flowers_app/core/base_response/base_response.dart';

@Injectable()
class OrdersViewModel extends Cubit<OrdersState> {
  final GetUserOrders getUserOrders;

  OrdersViewModel(this.getUserOrders) : super(const OrdersState());

  void doIntent(OrdersEvent event) {
    if (event is GetUserOrdersEvent) {
      _getOrders();
    } else if (event is ChangeOrdersFilterEvent) {
      _changeFilter(event.filter);
    }
  }

  Future<void> _getOrders() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final response = await getUserOrders.call(filter: state.selectedFilter);

    if (response is SuccessResponse<List<OrdersEntity>>) {
      if (state.selectedFilter == OrderFilter.pending) {
        emit(
          state.copyWith(
            isLoading: false,
            allOrders: response.data,
            activeOrders: response.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            allOrders: response.data,
            completedOrders: response.data,
          ),
        );
      }
    } else if (response is ErrorResponse<List<OrdersEntity>>) {
      emit(
        state.copyWith(isLoading: false, errorMessage: response.errorMessage),
      );
    }
  }

  Future<void> _changeFilter(OrderFilter filter) async {
    emit(state.copyWith(isFiltering: true, selectedFilter: filter));

    final response = await getUserOrders.call(filter: filter);

    if (response is SuccessResponse<List<OrdersEntity>>) {
      if (filter == OrderFilter.pending) {
        emit(state.copyWith(activeOrders: response.data, isFiltering: false));
      } else {
        emit(
          state.copyWith(completedOrders: response.data, isFiltering: false),
        );
      }
    } else {
      emit(state.copyWith(isFiltering: false));
    }
  }
}
