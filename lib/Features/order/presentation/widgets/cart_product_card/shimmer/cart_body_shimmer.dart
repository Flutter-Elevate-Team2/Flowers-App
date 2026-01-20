import 'package:flowers_app/Features/order/presentation/widgets/cart_product_card/shimmer/cart_product_card_shimmer.dart';
import 'package:flowers_app/Features/order/presentation/widgets/cart_product_card/shimmer/total_price_shimmer.dart';

import 'package:flutter/material.dart';

class CartBodyShimmer extends StatelessWidget {
  const CartBodyShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Cart Items List
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: CartProductCardShimmer(),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          // Subtotal & Total
          TotalPriceShimmer()
        ],
      ),
    );
  }
}
