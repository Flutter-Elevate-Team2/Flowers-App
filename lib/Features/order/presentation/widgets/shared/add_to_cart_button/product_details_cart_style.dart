import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/product_card/product_quantity_selector.dart';
import 'package:flowers_app/Features/order/presentation/widgets/shared/add_to_cart_button/cart_action_section.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class ProductDetailsCartStyle extends CartActionStyle {
  static const double buttonHeight = 54;

  @override
  Widget buildAddButton(
    BuildContext context, {
    required bool isLoading,
    required VoidCallback onAdd,
  }) {
    return SizedBox(
      height: buttonHeight,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onAdd,
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              )
            : Text(context.l10n.addToCart),
      ),
    );
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
      height: buttonHeight,
      iconSize: 22,
      fontSize: 18,
      borderRadius: BorderRadius.circular(27),
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
        onPressed: null, // disabled
        child: Text(
          context.l10n.outOfStock,
          style: TextStyle(color: Theme.of(context).canvasColor),
        ),
      ),
    );
  }
}
