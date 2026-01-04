
import 'package:equatable/equatable.dart';
import 'package:flowers_app/Features/order/domain/entities/cart_entity.dart';

class CartResponceEntity extends Equatable{
  final String? message;
  final int? numOfCartItems;
  final CartEntity? cart;

  const CartResponceEntity ({
    this.message,
    this.numOfCartItems,
    this.cart,
  });
  CartResponceEntity copyWith(String message,
      int numOfCartItems,
      CartEntity cart
      ){
    return CartResponceEntity(
      message: message,
       cart: cart,
      numOfCartItems: numOfCartItems
    );
  }

  @override
  List<Object?> get props => [message,cart,numOfCartItems];


}






