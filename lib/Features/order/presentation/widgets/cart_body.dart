import 'package:flowers_app/Features/order/domain/entities/cart_entity.dart';
import 'package:flowers_app/Features/order/presentation/view_model/cart_events.dart';
import 'package:flowers_app/Features/order/presentation/view_model/cart_view_model.dart';
import 'package:flowers_app/Features/order/presentation/widgets/cart_product_card/cart_product_card.dart';
import 'package:flowers_app/Features/order/presentation/widgets/cart_product_card/check_out_button.dart';
import 'package:flowers_app/Features/order/presentation/widgets/cart_product_card/total_price.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBody extends StatelessWidget {
  final CartEntity? cart;


  const CartBody({ this.cart , super.key});

  @override
  Widget build(BuildContext context) {
    final  items = cart?.cartItems ?? [];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Cart Items List
          Expanded(
            child: ListView.builder(
              itemCount: items.length ,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: CartProductCard(cartItem: item ,onToggleDelete: () {
                    context.read<CartViewModel>().doIntent(
                      DeleteCartItemEvent(item.product!.id) ,
                    );                  },) ,
                );
              },
            ),
          ),
          SizedBox(height: 16),
          // Subtotal & Total
          Column(
            children: [
            TotalPrice(totalPrice:cart!.totalPrice ),
              SizedBox(height: 48),
              // Checkout Button
              CheckOutButton()

            ],
          ),
        ],
      ),
    );
  }
}
