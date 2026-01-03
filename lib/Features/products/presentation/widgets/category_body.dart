import 'package:flowers_app/Features/products/presentation/view_model/products_view_model.dart';
import 'package:flowers_app/Features/products/presentation/widgets/category_products_content.dart';
import 'package:flowers_app/Features/products/presentation/widgets/default_tab_bar.dart';
import 'package:flowers_app/Features/products/presentation/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBody extends StatelessWidget {
  final TextEditingController searchController;
  final List<String> tabs;
  final ScrollController scrollController;

  const CategoryBody({
    super.key,
    required this.searchController,
    required this.tabs,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SearchAndFilterBar(
          searchController: searchController,
          onFocusChange: (focused) {
            context.read<ProductsViewModel>().onSearchFocusChanged(focused);
          },
          onFilterTap: () {},
          onSubmitted: (value) {
            context.read<ProductsViewModel>().onSearchSubmitted(value);
          },
        ),
        Material(child: DefaultTabBar(tabs)),
        Expanded(
          child: CategoryProductsContent(scrollController: scrollController),
        ),
      ],
    );
  }
}
