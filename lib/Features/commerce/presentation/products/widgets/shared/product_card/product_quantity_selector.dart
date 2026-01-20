import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ProductQuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final VoidCallback? onDelete;
  final bool isLoading;

  final bool isIncrementDisabled;
  final bool isDecrementDisabled;

  final double height;
  final double iconSize;
  final double fontSize;
  final BorderRadius borderRadius;

  ProductQuantitySelector({
    super.key,
    required this.quantity,
    required this.isIncrementDisabled,
    required this.isDecrementDisabled,
    this.onIncrement,
    this.onDecrement,
    this.onDelete,
    this.isLoading = false,
    this.height = 36,
    this.iconSize = 18,
    this.fontSize = 14,
    BorderRadius? borderRadius,
  }) : borderRadius = borderRadius ?? BorderRadius.circular(20);

  bool get _isDeleteMode => quantity == 1;

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = isLoading;

    Color? resolveIconColor(bool disabled) {
      if (disabled) return AppColors.white.withAlpha(150);
      return AppColors.white;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      height: height,
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: borderRadius,
      ),
      child: IgnorePointer(
        ignoring: isDisabled,
        child: Row(
          children: [
            // ───── Minus / Delete
            IconButton(
              iconSize: iconSize,
              splashRadius: 20,
              icon: Icon(
                _isDeleteMode ? Icons.delete_outline : Icons.remove,
                color: resolveIconColor(isDecrementDisabled),
              ),
              onPressed: isDecrementDisabled
                  ? null
                  : (_isDeleteMode ? onDelete : onDecrement),
            ),

            // ───── Quantity
            Expanded(
              child: Center(
                child: Text(
                  '$quantity',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // ───── Plus
            IconButton(
              iconSize: iconSize,
              splashRadius: 20,
              icon: Icon(
                Icons.add,
                color: resolveIconColor(isIncrementDisabled),
              ),
              onPressed: isIncrementDisabled ? null : onIncrement,
            ),
          ],
        ),
      ),
    );
  }
}
