import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';
import 'package:flowers_app/Features/order/presentation/widgets/shared/add_to_cart_button/cart_action_section.dart';
import 'package:flowers_app/Features/order/presentation/widgets/shared/add_to_cart_button/product_details_cart_style.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ProductDetailsBottomBar extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailsBottomBar({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: 32,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            offset: const Offset(0, -4),
            blurRadius: 10,
          ),
        ],
      ),

      child: CartActionSection(
        product: product,
        style: ProductDetailsCartStyle(),
      ),
    );
  }
}
