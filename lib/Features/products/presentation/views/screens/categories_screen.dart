import 'package:flowers_app/Features/products/presentation/view_model/products_events.dart';
import 'package:flowers_app/Features/products/presentation/view_model/products_view_model.dart';
import 'package:flowers_app/Features/products/presentation/widgets/categories_page.dart';
import 'package:flowers_app/Features/products/presentation/widgets/floating_button.dart';
import 'package:flowers_app/core/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProductsViewModel>()..doIntent(FetchProductsEvent()),
      child: Builder(
        builder: (context) {
          final viewModel = context.read<ProductsViewModel>();
          return Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingButton(viewModel),
            body: CategoriesPage(),
          );
        },
      ),
    );
  }
}
