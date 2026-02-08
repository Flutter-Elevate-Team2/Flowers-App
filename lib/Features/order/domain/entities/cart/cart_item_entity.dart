
import 'package:equatable/equatable.dart';

import '../../../products/domain/entities/product_entity.dart';

class CartItemEntity extends Equatable{

  final ProductEntity? product;

  final int? price;

  final int? quantity;
  final String? id;

  const CartItemEntity ({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });
  CartItemEntity copyWith (ProductEntity product,
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
