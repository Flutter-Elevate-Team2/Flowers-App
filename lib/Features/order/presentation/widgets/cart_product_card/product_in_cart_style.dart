import 'package:flowers_app/Features/order/presentation/widgets/shared/cart_action_style.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ProductInCartStyle extends CartActionStyle {
  @override
  Widget buildAddButton(
      BuildContext context, {
        required bool isLoading,
        required VoidCallback onAdd,
      }) {
    return const SizedBox.shrink();
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: onDecrement,
          color: AppColors.black,
        ),
        Text(quantity.toString()),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: onIncrement,
          color: AppColors.black,
        ),
      ],
    );
  }

  @override
  Widget buildSoldOut(BuildContext context) {
    return const SizedBox.shrink();
  }
}
