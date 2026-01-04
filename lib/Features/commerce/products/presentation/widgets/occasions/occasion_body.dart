import 'package:flowers_app/Features/commerce/home/domain/entities/home_entities/occasion_entity.dart';
import 'package:flowers_app/Features/commerce/products/presentation/view_model/products_events.dart';
import 'package:flowers_app/Features/commerce/products/presentation/view_model/products_view_model.dart';
import 'package:flowers_app/Features/commerce/products/presentation/widgets/shared/default_tab_bar.dart';
import 'package:flowers_app/Features/commerce/products/presentation/widgets/shared/paginated_products_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OccasionBody extends StatelessWidget {
  final List<String> tabs;
  final ScrollController scrollController;
  final List<OccasionEntity>? occasions;

  const OccasionBody({
    super.key,
    required this.tabs,
    required this.scrollController,
    this.occasions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: PaginatedProductsView(
        scrollController: scrollController,
        header: SliverToBoxAdapter(
          child: Material(
            child: DefaultTabBar(
              tabs,
              onTap: (index) {
                if (occasions != null && index < occasions!.length) {
                  final occasionId = occasions![index].id;
                  context.read<ProductsViewModel>().doIntent(
                    FetchProductsEvent(occasionId: occasionId),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
