import 'package:flowers_app/Features/commerce/data/mappers/product_mapper.dart';
import 'package:flowers_app/Features/order/data/models/cart/cart_item_dto.dart';
import 'package:flowers_app/Features/order/domain/entities/cart/cart_item_entity.dart';

extension CartItemMapper on CartItem{
  CartItemEntity toEntity(){
    return CartItemEntity(id:id,
        product:product?.toEntity() ,
        price:price ,
        quantity: quantity);
  }
}