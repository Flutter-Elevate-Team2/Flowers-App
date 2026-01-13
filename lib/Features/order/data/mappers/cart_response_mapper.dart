import 'package:flowers_app/Features/order/data/mappers/cart_mapper.dart';
import 'package:flowers_app/Features/order/data/models/cart_response_model.dart';
import 'package:flowers_app/Features/order/domain/entities/cart_response_entity.dart';

extension CartResponseMapper on CartResponseModel {
  CartResponseEntity toEntity() {
    return CartResponseEntity(
      numOfCartItems: numOfCartItems,
      cart: cart?.toEntity(),
      message: message,
    );
  }
}
