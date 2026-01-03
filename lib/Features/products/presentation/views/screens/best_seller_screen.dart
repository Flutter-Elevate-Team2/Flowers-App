import 'package:flowers_app/Features/products/presentation/view_model/products_view_model.dart';
import 'package:flowers_app/Features/products/presentation/widgets/best_seller_page.dart';
import 'package:flowers_app/core/di/di.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BestSellerScreen extends StatelessWidget {
  // final List<OccasionEntity>? bestSellers;
  // final int initialIndex;
  const BestSellerScreen({
    super.key,
    // this.bestSellers,
    // this.initialIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocProvider(
        // key: ValueKey(initialIndex),
        create: (context) {
          final viewModel = getIt<ProductsViewModel>();

          // if (bestSellers != null && bestSellers!.isNotEmpty && initialIndex < bestSellers!.length) {
          //   viewModel.doIntent(FetchProductsEvent(occasionId: bestSellers![initialIndex].id));
          // } else {
          //   viewModel.doIntent(FetchProductsEvent());
          // }
          //
          // if (bestSellers == null) {
          //   viewModel.doIntent(FetchBestSellersEvent());
          // }
          return viewModel;
        },
        child:
        const BestSellerPage(),
        // BlocBuilder<ProductsViewModel, ProductsStates>(
        //   builder: (context, state) {
        //     final effectiveBestSellers = bestSellers ?? state.bestSellersState?.data;
        //     return OccasionPage(
        //       bestSellers: effectiveBestSellers,
        //       initialIndex: initialIndex,
        //     );
        //   },
        // ),
      ),
    );
  }
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      leadingWidth: 50,
      titleSpacing: 0,
      title: Text((context).l10n.bestSellers),
      leading: IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        onPressed: () {
          context.pop();
        },
        icon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
    );
  }
}
