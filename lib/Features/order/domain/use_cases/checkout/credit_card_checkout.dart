import 'package:flowers_app/Features/order/data/models/checkout/order_request_dto.dart';
import 'package:flowers_app/Features/order/domain/entities/checkout/credit_checkout_response_entity.dart';
import 'package:flowers_app/Features/order/domain/repo/order_repo_contract.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreditCardCheckout {
  final OrderRepoContract _orderRepoContract;
  CreditCardCheckout(this._orderRepoContract);
  Future<BaseResponse<CreditCheckoutResponseEntity>> call(OrderRequest request) async {
    return await _orderRepoContract.creditOrderCheckout(request);
  }
}