import 'package:flowers_app/Features/products/presentation/view_model/products_states.dart';
import 'package:flowers_app/Features/products/presentation/widgets/occasion_products_list.dart';
import 'package:flowers_app/Features/products/presentation/widgets/products_grid_shimmer.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class OccasionProductsContent extends StatelessWidget {
  final ProductsStates state;
  final ScrollController scrollController;

  const OccasionProductsContent({
    super.key,
    required this.state,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final products = state.productsState?.data ?? [];

    if (state.productsState?.isLoading == true) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: ProductsGridShimmer(),
      );
    }

    if (state.productsState?.errorMessage != null) {
      return Center(child: Text(state.productsState!.errorMessage!));
    }

    if (products.isEmpty) {
      return Center(child: Text(context.l10n.noProductsFound));
    }

    return OccasionProductsList(
      products: products,
      isPaginationLoading: state.isPaginationLoading,
      scrollController: scrollController,
    );
  }
}
