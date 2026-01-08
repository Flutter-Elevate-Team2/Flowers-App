import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ProductQuantitySelector extends StatefulWidget {
  final int quantity;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final VoidCallback? onDelete;
  final bool isLoading;
  final double height;
  final double iconSize;
  final double fontSize;
  final BorderRadius borderRadius;
  final int? previousQuantity;

   ProductQuantitySelector({
    super.key,
    required this.quantity,
    this.onIncrement,
    this.onDecrement,
    this.onDelete,
    this.isLoading = false,
    this.height = 36,
    this.iconSize = 18,
    this.fontSize = 14,
    BorderRadius? borderRadius,
    this.previousQuantity,
  }) : borderRadius = borderRadius ?? BorderRadius.circular(20);

  @override
  State<ProductQuantitySelector> createState() =>
      _ProductQuantitySelectorState();
}

class _ProductQuantitySelectorState extends State<ProductQuantitySelector> {
  bool isIncrementPressed = false;
  bool isDecrementPressed = false;

  bool get isDeleteMode => widget.quantity == 1;

  @override
  Widget build(BuildContext context) {
    final isIncrement = (widget.previousQuantity ?? widget.quantity) < widget.quantity;

    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.isLoading
            ? Colors.grey.shade400
            : AppColors.mainColor,
        borderRadius: widget.borderRadius,
      ),
      child: Row(
        children: [
          // Minus / Delete Button
          GestureDetector(
            onTapDown: (_) {
              if (!widget.isLoading) setState(() => isDecrementPressed = true);
            },
            onTapUp: (_) {
              if (!widget.isLoading) setState(() => isDecrementPressed = false);
            },
            onTapCancel: () {
              if (!widget.isLoading) setState(() => isDecrementPressed = false);
            },
            child: IconButton(
              icon: Icon(
                isDeleteMode ? Icons.delete_outline : Icons.remove,
                color: isDecrementPressed ? Colors.grey.shade300 : Colors.white,
                size: widget.iconSize,
              ),
              onPressed: widget.isLoading
                  ? null
                  : isDeleteMode
                  ? widget.onDelete
                  : widget.onDecrement,
            ),
          ),

          // Animated Quantity
          Expanded(
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) {
                  final offsetAnimation = Tween<Offset>(
                    begin: Offset(0, isIncrement ? 1 : -1),
                    end: Offset.zero,
                  ).animate(animation);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
                child: Text(
                  "${widget.quantity}",
                  key: ValueKey<int>(widget.quantity),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: widget.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // Plus Button
          GestureDetector(
            onTapDown: (_) {
              if (!widget.isLoading) setState(() => isIncrementPressed = true);
            },
            onTapUp: (_) {
              if (!widget.isLoading) setState(() => isIncrementPressed = false);
            },
            onTapCancel: () {
              if (!widget.isLoading) setState(() => isIncrementPressed = false);
            },
            child: IconButton(
              icon: widget.isLoading
                  ? SizedBox(
                width: widget.iconSize,
                height: widget.iconSize,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
                  : Icon(
                Icons.add,
                color: isIncrementPressed ? Colors.grey.shade300 : Colors.white,
                size: widget.iconSize,
              ),
              onPressed: widget.isLoading ? null : widget.onIncrement,
            ),
          ),
        ],
      ),
    );
  }
}
