import 'package:flutter/material.dart';

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
