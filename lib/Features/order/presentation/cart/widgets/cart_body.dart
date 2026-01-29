import 'package:flowers_app/Features/order/domain/entities/cart/cart_entity.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_events.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_view_model.dart';
import 'package:flowers_app/Features/order/presentation/cart/widgets/cart_product_card/cart_product_card.dart';
import 'package:flowers_app/Features/order/presentation/cart/widgets/cart_product_card/total_price.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CartBody extends StatelessWidget {
  final CartEntity? cart;
  final String? locale;

  const CartBody({required this.cart, required this.locale, super.key});

  @override
  Widget build(BuildContext context) {
    final items = cart?.cartItems ?? [];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Cart Items List
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: CartProductCard(
                    cartItem: item,
                    onTap: () {
                      context.pushNamed(
                        Routes.productDetailsName,
                        extra: item.product,
                      );
                    },
                    onToggleDelete: () {
                      context.read<CartViewModel>().doIntent(
                        DeleteCartItemEvent(item.product!.id),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          // Subtotal & Total
          Column(
            children: [
              TotalPrice(
                subTotal: cart?.totalPrice ?? 0,
                deliveryFee: cart?.deliveryFee ?? 0,
                totalPrice: cart?.finalPrice ?? 0,
                locale: locale,
              ),
              SizedBox(height: 48),
              // Checkout Button
              CustomButton(
                title: context.l10n.checkout,
                onPressed: () {
                  if (!context.mounted) return;
                  context.pushNamed(Routes.checkoutName);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
