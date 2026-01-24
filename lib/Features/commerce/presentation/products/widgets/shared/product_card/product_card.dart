import 'package:flowers_app/Features/commerce/domain/entities/product_entities/product_entity.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/product_card/product_card_image.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/product_card/product_card_price_row.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_states.dart';
import 'package:flowers_app/Features/order/presentation/cart/view_model/cart_view_model.dart';
import 'package:flowers_app/Features/order/presentation/cart/widgets/shared/add_to_cart_button/cart_action_section.dart';
import 'package:flowers_app/Features/order/presentation/cart/widgets/shared/add_to_cart_button/product_card_cart_style.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return BlocBuilder<CartViewModel, CartStates>(
          buildWhen: (prev, curr) =>
          prev.updatingItemIds.contains(product.id) !=
              curr.updatingItemIds.contains(product.id),
          builder: (context, state) {
            final isLoading =
                state.updatingItemIds.contains(product.id) ||
                    state.optimisticQuantities.containsKey(product.id);

            return AbsorbPointer(
              absorbing: isLoading,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey,
                    width: .5,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Section
                      ProductCardImage(
                        imgCover: product.imgCover,
                        height: constraints.maxHeight * 0.55,
                      ),

                      // Content Section
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              ProductCardPriceRow(product: product),
                              const Spacer(),

                              // Add to Cart Button
                              CartActionSection(
                                product: product,
                                style: ProductCardCartStyle(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
