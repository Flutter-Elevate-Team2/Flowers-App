import 'package:flowers_app/Features/order/data/data_source/order_remote_data_source/order_remote_data_source_contract.dart';
import 'package:flowers_app/Features/order/data/mappers/cart/cart_response_mapper.dart';
import 'package:flowers_app/Features/order/data/mappers/checkout/cash_chekout_response_mapper.dart';
import 'package:flowers_app/Features/order/data/mappers/checkout/credit_chekout_response_mapper.dart';
import 'package:flowers_app/Features/order/data/mappers/checkout/orders_response_mapper.dart';
import 'package:flowers_app/Features/order/data/models/cart/cart_request_dto.dart';
import 'package:flowers_app/Features/order/data/models/cart/cart_response_model.dart';
import 'package:flowers_app/Features/order/data/models/cart/quantity_request.dart';
import 'package:flowers_app/Features/order/data/models/checkout/cash_checkout_response_model.dart';
import 'package:flowers_app/Features/order/data/models/checkout/credit/credit_checkout_response_model.dart';
import 'package:flowers_app/Features/order/data/models/checkout/order_request_dto.dart';
import 'package:flowers_app/Features/order/data/models/checkout/user_orders_response_model.dart';
import 'package:flowers_app/Features/order/domain/entities/cart/cart_response_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/cash_checkout_response_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/credit_checkout_response_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/user_orders_response_entity.dart';
import 'package:flowers_app/Features/order/domain/repo/order_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/helpers/api_execution_mixin.dart';

@LazySingleton(as: OrderRepoContract)
class OrderRepoImple with ApiExecutionMixin implements OrderRepoContract {
  final OrderRemoteDataSourceContract _orderRemoteDataSourceContract;
  OrderRepoImple(this._orderRemoteDataSourceContract);

  @override
  Future<BaseResponse<CartResponseEntity>> addToCart(
    CartRequest cartRequest,
  ) async {
    return execute<CartResponseModel, CartResponseEntity>(
      action: () => _orderRemoteDataSourceContract.addToCart(cartRequest),
      mapper: (response) => response.toEntity(),
    );
  }

  @override
  Future<BaseResponse<CartResponseEntity>> deleteFromCart(String id) {
    return execute<CartResponseModel, CartResponseEntity>(
      action: () => _orderRemoteDataSourceContract.deleteItemFromCart(id),
      mapper: (response) => response.toEntity(),
    );
  }

  @override
  Future<BaseResponse<CartResponseEntity>> getCartData() {
    return execute<CartResponseModel, CartResponseEntity>(
      action: () => _orderRemoteDataSourceContract.getCartData(),
      mapper: (response) => response.toEntity(),
    );
  }

  @override
  Future<BaseResponse<CartResponseEntity>> updateCartItem(
    String id,
    QuantityRequest quantityRequest,
  ) {
    return execute<CartResponseModel, CartResponseEntity>(
      action: () =>
          _orderRemoteDataSourceContract.updateCartItem(id, quantityRequest),
      mapper: (response) => response.toEntity(),
    );
  }

  @override
  Future<BaseResponse<CashCheckoutResponseEntity>> cashOrderCheckout(
    OrderRequest orderRequest,
  ) {
    return execute<CashCheckoutResponseModel, CashCheckoutResponseEntity>(
      action: () =>
          _orderRemoteDataSourceContract.cashOrderCheckout(orderRequest),
      mapper: (response) => response.toEntity(),
    );
  }

  @override
  Future<BaseResponse<CreditCheckoutResponseEntity>> creditOrderCheckout(
      OrderRequest orderRequest,
      ) {
    return execute<CreditCheckoutResponseModel, CreditCheckoutResponseEntity>(
      action: () =>
          _orderRemoteDataSourceContract.creditOrderCheckout(orderRequest),
      mapper: (response) => response.toEntity(),
    );
  }
  @override
  Future<BaseResponse<UserOrdersResponseEntity>> getUserOrders(
      ) {
    return execute<UserOrdersResponseModel, UserOrdersResponseEntity>(
      action: () =>
          _orderRemoteDataSourceContract.getUserOrders(),
      mapper: (response) => response.toEntity(),
    );
  }
}
