import 'package:flowers_app/Features/products/presentation/view_model/products_states.dart';
import 'package:flowers_app/Features/products/presentation/view_model/products_view_model.dart';
import 'package:flowers_app/Features/products/presentation/widgets/default_tab_bar.dart';
import 'package:flowers_app/Features/products/presentation/widgets/products_grid.dart';
import 'package:flowers_app/Features/products/presentation/widgets/search.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    final tabs = ["All", "Plants", "Flowers", "Pots", "Seeds"];

    return SafeArea(
      child: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          body: Column(
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
                onChanged: (value) {
                  context.read<ProductsViewModel>().onSearchSubmitted(value);
                },
              ),
              Material(child: DefaultTabBar(tabs)),
              Expanded(
                child: BlocBuilder<ProductsViewModel, ProductsStates>(
                  builder: (context, state) {
                    final products = state.productsState?.data ?? [];

                    if (state.isSearchFocused ) {
                      return Center(child: Text(context.l10n.searchFor));
                    }
                    if (state.productsState?.isLoading == true) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.productsState?.errorMessage != null) {
                      return Center(
                        child: Text(state.productsState!.errorMessage!),
                      );
                    }
                    if (state.searchText.isNotEmpty && state.productsState?.isLoading == false && products.isEmpty ) {
                      return Center(child: Text(context.l10n.noProductsFound));
                    }
                    return ProductsGrid(products);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
