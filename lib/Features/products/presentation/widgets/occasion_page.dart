import 'package:flowers_app/Features/products/domain/entities/product_entity.dart';
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
        child: _buildOccasionBody(context, tabs),
      ),
    );
  }

  Column _buildOccasionBody(BuildContext context, List<String> tabs) {
    return Column(
      children: [
        _buildOccasionDescription(context),
        Material(child: DefaultTabBar(tabs)),
        Expanded(
          child: BlocBuilder<ProductsViewModel, ProductsStates>(
            builder: (context, state) {
              return _buildProductsContent(context, state);
            },
          ),
        ),
      ],
    );
  }

  Padding _buildOccasionDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        context.l10n.occasionDescription,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }

  Widget _buildProductsContent(BuildContext context, ProductsStates state) {
    final products = state.productsState?.data ?? [];

    if (state.productsState?.isLoading == true) {
      return const ProductsGridShimmer();
    }

    if (state.productsState?.errorMessage != null) {
      return Center(child: Text(state.productsState!.errorMessage!));
    }

    if (products.isEmpty) {
      return Center(child: Text(context.l10n.noProductsFound));
    }

    // ===== Scrollable Grid + Pagination =====
    return _buildProductsList(products, state, context);
  }

  ListView _buildProductsList(
    List<ProductEntity> products,
    ProductsStates state,
    BuildContext context,
  ) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ProductsGrid(
          products: products,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        ),
        if (state.totalPages > 1) _buildPagination(state, context),
      ],
    );
  }

  Padding _buildPagination(ProductsStates state, BuildContext context) {
    return Padding(
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
    );
  }
}
