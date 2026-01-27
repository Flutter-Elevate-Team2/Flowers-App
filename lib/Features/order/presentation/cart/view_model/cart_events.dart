import 'package:flowers_app/Features/order/data/models/cart/cart_request_dto.dart';
import 'package:flowers_app/Features/order/data/models/cart/quantity_request.dart';

sealed class CartEvent {}

class GetCartDataEvent extends CartEvent {
}

class AddToCartEvent extends CartEvent {
  final CartRequest cartRequest;
  AddToCartEvent(this.cartRequest);
}

class DeleteCartItemEvent extends CartEvent {
  final String itemId;
  DeleteCartItemEvent(this.itemId);
}

class UpdateCartItemEvent extends CartEvent {
  final String itemId;
  final QuantityRequest quantityRequest;
  UpdateCartItemEvent({required this.itemId, required this.quantityRequest});
}

class CartLoginHandledEvent extends CartEvent {}

class ClearCartEvent extends CartEvent {}