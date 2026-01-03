import 'package:flowers_app/Features/products/domain/entities/product_entity.dart';
import 'package:flowers_app/Features/products/presentation/widgets/products_grid.dart';
import 'package:flowers_app/Features/products/presentation/widgets/products_grid_shimmer.dart';
import 'package:flutter/material.dart';

class OccasionProductsList extends StatelessWidget {
  final List<ProductEntity> products;
  final bool isPaginationLoading;
  final ScrollController scrollController;

  const OccasionProductsList({
    super.key,
    required this.products,
    required this.isPaginationLoading,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: scrollController,
     
      children: [
        ProductsGrid(
          products: products,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        ),
        if (isPaginationLoading)
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: ProductsGridShimmer(
              itemCount: 4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
          ),
        const SizedBox(height: 50),
      ],
    );
  }
}
