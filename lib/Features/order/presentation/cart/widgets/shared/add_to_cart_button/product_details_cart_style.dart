import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/product_card/product_quantity_selector.dart';
import 'package:flowers_app/Features/order/presentation/cart/widgets/shared/cart_action_style.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class ProductDetailsCartStyle extends CartActionStyle {
  static const double buttonHeight = 54;

  @override
  Widget buildAddButton(
    BuildContext context, {
    Key? key,
    required bool isLoading,
    required VoidCallback onAdd,
  }) {
    return SizedBox(
      height: buttonHeight,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onAdd,
        child: isLoading
            ? CircularProgressIndicator(color: AppColors.white, strokeWidth: 2)
            : Text(context.l10n.addToCart),
      ),
    );
  }

  @override
  Widget buildQuantitySelector(
    BuildContext context, {
    Key? key,
    required int quantity,
    required bool isLoading,
    required bool isIncrementDisabled,
    required bool isDecrementDisabled,
    required VoidCallback? onIncrement,
    required VoidCallback? onDecrement,
    required VoidCallback? onDelete,
  }) {
    return ProductQuantitySelector(
      key: key,
      quantity: quantity,
      height: buttonHeight,
      iconSize: 22,
      fontSize: 18,
      borderRadius: BorderRadius.circular(27),
      isLoading: isLoading,

      isIncrementDisabled: isIncrementDisabled,
      isDecrementDisabled: isDecrementDisabled,

      onIncrement: onIncrement,
      onDecrement: onDecrement,
      onDelete: onDelete,
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
