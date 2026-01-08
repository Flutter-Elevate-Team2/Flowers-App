import 'package:flowers_app/Features/order/domain/entities/cart_response_entity.dart';

class CartStates {
  final CartResponseEntity? cartData;

  final bool isUpdatingItem;
  final String? updatingItemId;

  final String? errorMessage;

  CartStates({
    this.cartData,
    this.isUpdatingItem = false,
    this.updatingItemId,
    this.errorMessage,
  });

  CartStates copyWith({
    CartResponseEntity? cartData,
    bool? isUpdatingItem,
    String? updatingItemId,
    String? errorMessage,
  }) {
    return CartStates(
      cartData: cartData ?? this.cartData,
      isUpdatingItem: isUpdatingItem ?? this.isUpdatingItem,
      updatingItemId: updatingItemId,
      errorMessage: errorMessage,
    );
  }
}
