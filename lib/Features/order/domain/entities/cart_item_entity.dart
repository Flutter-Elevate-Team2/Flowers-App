
import 'package:equatable/equatable.dart';

import '../../../products/data/models/products_model/products_dto.dart';


class CartItemEntity extends Equatable{

  final Products? product;

  final int? price;

  final int? quantity;
  final String? id;

  const CartItemEntity ({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });
  CartItemEntity copyWith (Products product,
      int price,
      int quantity,
      String id

  ){
    return CartItemEntity(
      id: id,
      quantity: quantity,
      price: price,
      product: product
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [product,price,quantity,id];


}
