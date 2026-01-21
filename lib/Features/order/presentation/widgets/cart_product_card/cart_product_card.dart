import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';
import 'package:flowers_app/Features/order/domain/entities/cart_item_entity.dart';
import 'package:flowers_app/Features/order/presentation/widgets/cart_product_card/cart_product_card_image.dart';
import 'package:flowers_app/Features/order/presentation/widgets/cart_product_card/product_in_cart_style.dart';
import 'package:flowers_app/Features/order/presentation/widgets/shared/add_to_cart_button/cart_action_section.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class CartProductCard extends StatelessWidget {
  final CartItemEntity cartItem;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final VoidCallback? onToggleDelete;

  const CartProductCard({
    super.key,
    required this.cartItem,
    this.onTap,
    this.onAddToCart,
    this.onToggleDelete,
  });

  @override
  Widget build(BuildContext context) {
    ProductEntity product = cartItem.product!;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: EdgeInsets.all(8),
          height: 121,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.gray.withValues(alpha: 0.5),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Section
                Container(
                  margin: EdgeInsets.only(right: 8),
                  width: 100,
                  height: 100,
                  child: CartProductCardImage(
                    imgCover: product.imgCover,
                    height: 120,
                  ),
                ),

                // Content Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              product.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(color: AppColors.black),
                            ),
                          ),

                          GestureDetector(
                            onTap: onToggleDelete,
                            child: Icon(
                              Icons.delete_outline,
                              color: AppColors.red,
                            ),
                          ),
                        ],
                      ),
                      //Description
                      SizedBox(height: 4),
                      Text(
                        product.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: AppColors.gray),
                      ),
                      Spacer(),
                      Padding(padding: EdgeInsetsGeometry.only(bottom: 8),
                      child: Row(
                        children: [
                          // Price
                          Expanded(
                            child: Text(
                              '${context.l10n.egp} ${cartItem.price}',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          CartActionSection(
                            product: product,
                            style: ProductInCartStyle(),
                          )

                        ],
                      ),)

                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
