import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/product_card/product_card_add_to_cart_button.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/product_card/product_quantity_selector.dart';
import 'package:flowers_app/Features/order/presentation/widgets/shared/cart_action_style.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class ProductCardCartStyle extends CartActionStyle {
  static const double buttonHeight = 36;

  @override
  Widget buildAddButton(
    BuildContext context, {
    required bool isLoading,
    required VoidCallback onAdd,
  }) {
    return ProductCardAddToCartButton(onAddToCart: isLoading ? null : onAdd);
  }

  @override
  Widget buildQuantitySelector(
    BuildContext context, {
    required int quantity,
    required bool isLoading,
    required VoidCallback? onIncrement,
    required VoidCallback? onDecrement,
    required VoidCallback? onDelete,
  }) {
    return ProductQuantitySelector(
      quantity: quantity,
      onIncrement: isLoading ? null : onIncrement,
      onDecrement: isLoading ? null : onDecrement,
      onDelete: isLoading ? null : onDelete,
    );
  }

  @override
  Widget buildSoldOut(BuildContext context) {
    return SizedBox(
      height: buttonHeight,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: null,
        child: Text(
          context.l10n.outOfStock,
          style: TextStyle(color: Theme.of(context).canvasColor),
        ),
      ),
    );
  }
}
