
import 'package:equatable/equatable.dart';
import 'package:flowers_app/Features/order/domain/entities/cart_entity.dart';

class CartResponseEntity extends Equatable{
  final String? message;
  final int? numOfCartItems;
  final CartEntity? cart;

  const CartResponseEntity ({
    this.message,
    this.numOfCartItems,
    this.cart,
  });
  CartResponseEntity copyWith(String message,
      int numOfCartItems,
      CartEntity cart
      ){
    return CartResponseEntity(
      message: message,
       cart: cart,
      numOfCartItems: numOfCartItems
    );
  }

  @override
  List<Object?> get props => [message,cart,numOfCartItems];


}






