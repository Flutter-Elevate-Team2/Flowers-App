import 'package:flowers_app/Features/commerce/home/domain/entities/home_entities/category_entity.dart';
import 'package:flowers_app/Features/commerce/products/presentation/view_model/products_events.dart';
import 'package:flowers_app/Features/commerce/products/presentation/view_model/products_states.dart';
import 'package:flowers_app/Features/commerce/products/presentation/view_model/products_view_model.dart';
import 'package:flowers_app/Features/commerce/products/presentation/widgets/categories/categories_page.dart';
import 'package:flowers_app/Features/commerce/products/presentation/widgets/shared/floating_button.dart';
import 'package:flowers_app/core/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  final List<CategoryEntity>? categories;
  final int initialIndex;

  const CategoriesScreen({super.key, this.categories, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      key: ValueKey(initialIndex),
      create: (context) {
        final viewModel = getIt<ProductsViewModel>();

        if (initialIndex > 0 &&
            categories != null &&
            categories!.length >= initialIndex) {
          viewModel.doIntent(
            FetchProductsEvent(categoryId: categories![initialIndex - 1].id),
          );
        } else {
          viewModel.doIntent(FetchProductsEvent());
        }

        if (categories == null) {
          viewModel.doIntent(FetchCategoriesEvent());
        }
        return viewModel;
      },
      child: Builder(
        builder: (context) {
          final viewModel = context.read<ProductsViewModel>();
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingButton(viewModel),
            body: BlocBuilder<ProductsViewModel, ProductsStates>(
              builder: (context, state) {
                final effectiveCategories =
                    categories ?? state.categoriesState?.data;
                return CategoriesPage(
                  categories: effectiveCategories,
                  initialIndex: initialIndex,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
