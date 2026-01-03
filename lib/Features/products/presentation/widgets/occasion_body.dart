import 'package:flowers_app/Features/products/presentation/view_model/products_states.dart';
import 'package:flowers_app/Features/products/presentation/view_model/products_view_model.dart';
import 'package:flowers_app/Features/products/presentation/widgets/default_tab_bar.dart';
import 'package:flowers_app/Features/products/presentation/widgets/occasion_description.dart';
import 'package:flowers_app/Features/products/presentation/widgets/occasion_products_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OccasionBody extends StatelessWidget {
  final List<String> tabs;
  final ScrollController scrollController;
  // final List<OccasionEntity>? occasions;

  const OccasionBody({
    super.key,
    required this.tabs,
    required this.scrollController,
    // this.occasions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const OccasionDescription(),
        Material(
          child: DefaultTabBar(
            tabs,
            // onTap: (index) {
            //   if (occasions != null && index < occasions!.length) {
            //     final occasionId = occasions![index].id;
            //     context.read<ProductsViewModel>().doIntent(
            //       FetchProductsEvent(occasionId: occasionId),
            //     );
            //   }
            // },
          ),
        ),
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
