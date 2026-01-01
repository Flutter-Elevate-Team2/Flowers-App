import 'package:flowers_app/Features/products/presentation/view_model/products_states.dart';
import 'package:flowers_app/Features/products/presentation/view_model/products_view_model.dart';
import 'package:flowers_app/Features/products/presentation/widgets/default_tab_bar.dart';
import 'package:flowers_app/Features/products/presentation/widgets/pagination_bar.dart';
import 'package:flowers_app/Features/products/presentation/widgets/products_grid.dart';
import 'package:flowers_app/Features/products/presentation/widgets/products_grid_shimmer.dart';
import 'package:flowers_app/Features/products/presentation/widgets/search.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    final tabs = ["All", "Plants", "Flowers", "Pots", "Seeds"];

    return SafeArea(
      child: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          body: _buildCategoryBody(searchController, context, tabs),
        ),
      ),
    );
  }

  Column _buildCategoryBody(TextEditingController searchController, BuildContext context, List<String> tabs) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SearchAndFilterBar(
              searchController: searchController,
              onFocusChange: (focused) {
                context.read<ProductsViewModel>().onSearchFocusChanged(
                  focused,
                );
              },
              onFilterTap: () {},
              onSubmitted: (value) {
                context.read<ProductsViewModel>().onSearchSubmitted(value);
              },
            ),
            Material(child: DefaultTabBar(tabs)),
            Expanded(
              child: _buildProductsContent(),
            ),
          ],
        );
  }

  BlocBuilder<ProductsViewModel, ProductsStates> _buildProductsContent() {
    return BlocBuilder<ProductsViewModel, ProductsStates>(
                builder: (context, state) {
                  final products = state.productsState?.data ?? [];
                  return CustomScrollView(
                    slivers: [
                      if (state.isSearchFocused)
                        SliverFillRemaining(
                          child: Center(child: Text(context.l10n.searchFor)),
                        )
                      else if (state.productsState?.isLoading == true ||
                          (state.productsState?.data?.isEmpty ?? true))
                        const SliverFillRemaining(
                          child: Padding(
                            padding:  EdgeInsets.all(16),
                            child: ProductsGridShimmer(),
                          ),
                        )
                      else if (state.productsState?.errorMessage != null)
                        SliverFillRemaining(
                          child: Center(
                            child: Text(state.productsState!.errorMessage!),
                          ),
                        )
                      else if (state.searchText.isNotEmpty &&
                          state.productsState?.isLoading == false &&
                          products.isEmpty)
                        SliverFillRemaining(
                          child: Center(
                            child: Text(context.l10n.noProductsFound),
                          ),
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
                        if (state.totalPages > 1)
                          _buildPaginationSliver(state, context),
                        const SliverToBoxAdapter(child: SizedBox(height: 50)),
                      ],
                    ],
                  );
                },
              );
  }

  SliverToBoxAdapter _buildPaginationSliver(ProductsStates state, BuildContext context) {
    return SliverToBoxAdapter(
                          child: PaginationBar(
                            currentPage: state.currentPage,
                            totalPages: state.totalPages,
                            prevPage: state.prevPage,
                            nextPage: state.nextPage,
                            onPageSelected: (page) {
                              context.read<ProductsViewModel>().goToPage(
                                page,
                              );
                            },
                            onNext: state.nextPage != null
                                ? context
                                      .read<ProductsViewModel>()
                                      .goToNextPage
                                : null,
                            onPrev: state.prevPage != null
                                ? context
                                      .read<ProductsViewModel>()
                                      .goToPrevPage
                                : null,
                          ),
                        );
  }
}
