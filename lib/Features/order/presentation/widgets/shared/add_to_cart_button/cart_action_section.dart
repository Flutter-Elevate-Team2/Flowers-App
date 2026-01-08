import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';
import 'package:flowers_app/Features/order/data/models/cart_request_dto.dart';
import 'package:flowers_app/Features/order/data/models/quantity_request.dart';
import 'package:flowers_app/Features/order/domain/entities/cart_item_entity.dart';
import 'package:flowers_app/Features/order/presentation/view_model/cart_events.dart';
import 'package:flowers_app/Features/order/presentation/view_model/cart_states.dart';
import 'package:flowers_app/Features/order/presentation/view_model/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartActionSection extends StatelessWidget {
  final ProductEntity product;
  final CartActionStyle style;

  const CartActionSection({
    super.key,
    required this.product,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartViewModel, CartStates, CartItemEntity?>(
      selector: (state) {
        final items = state.cartData?.cart?.cartItems ?? [];

        CartItemEntity? cartItem;
        for (var e in items) {
          if (e.product?.id == product.id) {
            cartItem = e;
            break;
          }
        }
        return cartItem;
      },
      builder: (context, cartItem) {
        final state = context.watch<CartViewModel>().state;
        final isLoading =
            state.isUpdatingItem && state.updatingItemId == product.id;

        final maxQuantity = product.quantity;

        // ❌ Sold out
        if (maxQuantity <= 0) {
          return style.buildSoldOut(context);
        }

        // ✅ In cart → quantity selector
        if (cartItem != null) {
          final quantity = cartItem.quantity ?? 1;

          return style.buildQuantitySelector(
            context,
            quantity: quantity,
            isLoading: isLoading,
            onIncrement: quantity >= maxQuantity || isLoading
                ? null
                : () {
              context.read<CartViewModel>().doIntent(
                UpdateCartItemEvent(
                  itemId: product.id,
                  quantityRequest: QuantityRequest(quantity: quantity + 1),
                ),
              );
            },
            onDecrement: isLoading || quantity <= 1
                ? null
                : () {
              context.read<CartViewModel>().doIntent(
                UpdateCartItemEvent(
                  itemId: product.id,
                  quantityRequest: QuantityRequest(quantity: quantity - 1),
                ),
              );
            },
            onDelete: isLoading
                ? null
                : () {
              context.read<CartViewModel>().doIntent(
                DeleteCartItemEvent(product.id),
              );
            },
          );

        }

        // ➕ Not in cart
        return style.buildAddButton(
          context,
          isLoading: isLoading,
          onAdd: () {
            context.read<CartViewModel>().doIntent(
              AddToCartEvent(
                CartRequest(product: product.id, quantity: 1),
              ),
            );
          },
        );
      },
    );
  }
}
abstract class CartActionStyle {
  Widget buildAddButton(
      BuildContext context, {
        required bool isLoading,
        required VoidCallback onAdd,
      });

  Widget buildQuantitySelector(
      BuildContext context, {
        required int quantity,
        required bool isLoading,
        required VoidCallback? onIncrement,
        required VoidCallback? onDecrement,
        required VoidCallback? onDelete,
      });

  Widget buildSoldOut(BuildContext context);
}
