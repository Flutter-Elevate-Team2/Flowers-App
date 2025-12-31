import 'package:flowers_app/Features/products/presentation/view_model/products_states.dart';
import 'package:flowers_app/Features/products/presentation/view_model/products_view_model.dart';
import 'package:flowers_app/Features/products/presentation/widgets/default_tab_bar.dart';
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
        child: BlocBuilder<ProductsViewModel, ProductsStates>(
            builder: (context, state) {
              final products = state.productsState?.data ?? [];

              if (state.productsState?.isLoading == true) {
                return Expanded(child: ProductsGridShimmer());
              }

              if (state.productsState?.errorMessage != null) {
                return Center(child: Text(state.productsState!.errorMessage!));
              }

              if (products.isEmpty) {
                return Center(child: Text((context).l10n.noProductsFound));
              }
              return Column(
                children: [
                  Text((context).l10n.occasionDescription,
                  style: Theme.of(context).textTheme.bodySmall),
                  Material(
                    child: DefaultTabBar(tabs),
                  ),
                  Expanded(child: ProductsGrid(products: products)),
                ],
              );
            },
          ),
        ),
    );
  }
}
