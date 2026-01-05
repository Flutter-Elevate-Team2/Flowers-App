import 'package:flowers_app/Features/commerce/presentation/products/view_model/products_states.dart';
import 'package:flowers_app/Features/commerce/presentation/products/view_model/products_view_model.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/shared/products_grid.dart';
import 'package:flowers_app/Features/commerce/presentation/products/widgets/shimmers/products_grid_shimmer.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/helpers/error_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaginatedProductsView extends StatelessWidget {
  final ScrollController scrollController;
  final Widget? header;

  const PaginatedProductsView({
    super.key,
    required this.scrollController,
    this.header,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsViewModel, ProductsStates>(
      builder: (context, state) {
        final products = state.productsState?.data ?? [];

        return CustomScrollView(
          controller: scrollController,
          slivers: [
            if (header != null) header!,
            if (state.isSearchFocused)
              SliverFillRemaining(
                child: Center(child: Text(context.l10n.searchFor)),
              )
            else if (state.productsState?.isLoading == true)
              const SliverFillRemaining(child: ProductsGridShimmer())
            else if (state.productsState?.errorMessage != null)
              SliverFillRemaining(
                child: Center(
                  child: Text(
                    ErrorMapper.mapError(
                      context,
                      state.productsState!.errorMessage!,
                    ),
                  ),
                ),
              )
            else if (state.productsState?.isLoading == false &&
                products.isEmpty)
              SliverFillRemaining(
                child: Center(child: Text(context.l10n.noProductsFound)),
              )
            else ...[
              SliverToBoxAdapter(
                child: ProductsGrid(
                  products: products,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ),
              if (state.isPaginationLoading)
                const SliverToBoxAdapter(
                  child: ProductsGridShimmer(
                    itemCount: 4,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
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
