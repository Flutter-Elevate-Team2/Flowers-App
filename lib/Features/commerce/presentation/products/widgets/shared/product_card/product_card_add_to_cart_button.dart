import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ProductCardAddToCartButton extends StatelessWidget {
  final VoidCallback? onAddToCart;

  const ProductCardAddToCartButton({super.key, this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 36,
      child: ElevatedButton(
        onPressed: onAddToCart ?? () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mainColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 6),
            const Text(
              "Add to cart",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
