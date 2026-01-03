import 'package:flowers_app/Features/products/presentation/widgets/occasion_description.dart';
import 'package:flowers_app/Features/products/presentation/widgets/paginated_products_view.dart';
import 'package:flutter/material.dart';

class BestSellerBody extends StatelessWidget {
  final ScrollController scrollController;

  const BestSellerBody({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return PaginatedProductsView(
      scrollController: scrollController,
      header: const SliverToBoxAdapter(child: OccasionDescription()),
    );
  }
}
