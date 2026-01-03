import 'package:flowers_app/Features/products/presentation/view_model/products_states.dart';
import 'package:flowers_app/Features/products/presentation/view_model/products_view_model.dart';
import 'package:flowers_app/Features/products/presentation/widgets/default_tab_bar.dart';
import 'package:flowers_app/Features/products/presentation/widgets/occasion_description.dart';
import 'package:flowers_app/Features/products/presentation/widgets/occasion_products_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BestSellerBody extends StatelessWidget {
  final List<String> tabs;
  final ScrollController scrollController;

  const BestSellerBody({
    super.key,
    required this.tabs,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const OccasionDescription(),
        Material(child: DefaultTabBar(tabs)),
        Expanded(
          child: BlocBuilder<ProductsViewModel, ProductsStates>(
            builder: (context, state) {
              return OccasionProductsContent(
                state: state,
                scrollController: scrollController,
              );
            },
          ),
        ),
      ],
    );
  }
}
