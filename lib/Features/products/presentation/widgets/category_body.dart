import 'package:flowers_app/Features/products/presentation/view_model/products_events.dart';
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
  // final List<CategoryEntity>? categories;

  const CategoryBody({
    super.key,
    required this.searchController,
    required this.tabs,
    required this.scrollController,
    // this.categories,
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
        Material(
            child: DefaultTabBar(
              tabs,
              onTap: (index) {
                if (index == 0) {
                  // "All" tab
                  context.read<ProductsViewModel>().doIntent(
                    FetchProductsEvent(),
                  );
                } else {
                  // Specific category
                  // if (categories != null && index - 1 < categories!.length) {
                  //   final categoryId = categories![index - 1].id;
                  //   context.read<ProductsViewModel>().doIntent(
                  //     FetchProductsEvent(categoryId: categoryId),
                  //   );
                  // }
                }
              },
            ),
        ),
        Expanded(
          child: CategoryProductsContent(scrollController: scrollController),
        ),
      ],
    );
  }
}