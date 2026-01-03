import 'package:flowers_app/Features/products/presentation/view_model/products_states.dart';
import 'package:flowers_app/Features/products/presentation/view_model/products_view_model.dart';
import 'package:flowers_app/Features/products/presentation/widgets/products_grid.dart';
import 'package:flowers_app/Features/products/presentation/widgets/products_grid_shimmer.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductsContent extends StatelessWidget {
  final ScrollController scrollController;

  const CategoryProductsContent({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsViewModel, ProductsStates>(
      builder: (context, state) {
        final products = state.productsState?.data ?? [];
        return CustomScrollView(
          controller: scrollController,
          slivers: [
            if (state.isSearchFocused)
              SliverFillRemaining(
                child: Center(child: Text(context.l10n.searchFor)),
              )
            else if (state.productsState?.isLoading == true ||
                (state.productsState?.data?.isEmpty ?? true) &&
                    state.productsState?.errorMessage == null)
              const SliverFillRemaining(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: ProductsGridShimmer(),
                ),
              )
            else if (state.productsState?.errorMessage != null)
              SliverFillRemaining(
                child: Center(child: Text(state.productsState!.errorMessage!)),
              )
            else if (state.searchText.isNotEmpty &&
                state.productsState?.isLoading == false &&
                products.isEmpty)
              SliverFillRemaining(
                child: Center(child: Text(context.l10n.noProductsFound)),
              )
            else ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ProductsGrid(
                    products: products,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                ),
              ),
              if (state.isPaginationLoading)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: ProductsGridShimmer(
                      itemCount: 4,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ),
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 50)),
            ],
          ],
        );
      },
    );
  }
}
