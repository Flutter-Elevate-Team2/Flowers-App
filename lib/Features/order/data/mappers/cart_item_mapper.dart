import 'package:flowers_app/Features/order/data/models/cart_item_dto.dart';
import 'package:flowers_app/Features/products/data/mappers/product_mapper.dart';
import '../../domain/entities/cart_item_entity.dart';

extension CartItemMapper on CartItem{
  CartItemEntity toEntity(){
    return CartItemEntity(id:id,
        product:product?.toEntity() ,
        price:price ,
        quantity: quantity);
  }
}