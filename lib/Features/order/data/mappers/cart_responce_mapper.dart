import 'package:flowers_app/Features/order/data/mappers/cart_mapper.dart';
import 'package:flowers_app/Features/order/data/models/cart_responce_model.dart';
import 'package:flowers_app/Features/order/domain/entities/cart_responce_entity.dart';

extension CartMapper on CartResponceModel{
  CartResponceEntity toEntity(){
    return CartResponceEntity(numOfCartItems:numOfCartItems,cart:cart?.toEntity(),message: message);
  }
}