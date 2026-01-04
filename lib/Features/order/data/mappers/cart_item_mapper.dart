import 'package:flowers_app/Features/order/data/models/cart_item_dto.dart';
import '../../domain/entities/cart_item_entity.dart';

extension CartItemMapper on CartItem{
  CartItemEntity toEntity(){
    return CartItemEntity(id:id,
        product:product ,
        price:price ,
        quantity: quantity);
  }
}