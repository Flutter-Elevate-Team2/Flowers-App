import 'package:flutter/material.dart';

abstract class CartActionStyle {
  Widget buildAddButton(
    BuildContext context, {
    Key? key,
    required bool isLoading,
    required VoidCallback onAdd,
  });

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
  });

  Widget buildSoldOut(BuildContext context);
}
