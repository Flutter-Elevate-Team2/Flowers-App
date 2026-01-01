import 'package:flowers_app/Features/products/presentation/view_model/products_states.dart';
import 'package:flowers_app/Features/products/presentation/view_model/products_view_model.dart';
import 'package:flowers_app/Features/products/presentation/widgets/default_tab_bar.dart';
import 'package:flowers_app/Features/products/presentation/widgets/pagination_bar.dart';
import 'package:flowers_app/Features/products/presentation/widgets/products_grid.dart';
import 'package:flowers_app/Features/products/presentation/widgets/products_grid_shimmer.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OccasionPage extends StatelessWidget {
  const OccasionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = ["All", "Plants", "Flowers", "Pots", "Seeds"];

    return SafeArea(
      child: DefaultTabController(
        length: tabs.length,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                context.l10n.occasionDescription,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            Material(child: DefaultTabBar(tabs)),
            Expanded(
              child: BlocBuilder<ProductsViewModel, ProductsStates>(
                builder: (context, state) {
                  final products = state.productsState?.data ?? [];

                  // Loading
                  if (state.productsState?.isLoading == true) {
                    return const ProductsGridShimmer();
                  }

                  // Error
                  if (state.productsState?.errorMessage != null) {
                    return Center(
                      child: Text(state.productsState!.errorMessage!),
                    );
                  }

                  // Empty
                  if (products.isEmpty) {
                    return Center(
                      child: Text(context.l10n.noProductsFound),
                    );
                  }

                  // ===== Scrollable Grid + Pagination =====
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      ProductsGrid(
                        products: products,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                      if (state.totalPages > 1)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: PaginationBar(
                            currentPage: state.currentPage,
                            totalPages: state.totalPages,
                            prevPage: state.prevPage,
                            nextPage: state.nextPage,
                            onPageSelected: (page) {
                              context.read<ProductsViewModel>().goToPage(page);
                            },
                            onNext: state.nextPage != null
                                ? context.read<ProductsViewModel>().goToNextPage
                                : null,
                            onPrev: state.prevPage != null
                                ? context.read<ProductsViewModel>().goToPrevPage
                                : null,
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
