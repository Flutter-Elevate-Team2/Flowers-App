import 'package:flowers_app/Features/products/presentation/view_model/products_events.dart';
import 'package:flowers_app/Features/products/presentation/view_model/products_view_model.dart';
import 'package:flowers_app/Features/products/presentation/widgets/occasion_page.dart';
import 'package:flowers_app/core/di/di.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OccasionsScreen extends StatelessWidget {
  // final List<OccasionEntity>? occasions;
  // final int initialIndex;
  const OccasionsScreen({
    super.key,
    // this.occasions,
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

          // if (occasions != null && occasions!.isNotEmpty && initialIndex < occasions!.length) {
          //   viewModel.doIntent(FetchProductsEvent(occasionId: occasions![initialIndex].id));
          // } else {
          //   viewModel.doIntent(FetchProductsEvent());
          // }
          //
          // if (occasions == null) {
          //   viewModel.doIntent(FetchOccasionsEvent());
          // }
          return viewModel;
        },
        child:
        const OccasionPage(),
        // BlocBuilder<ProductsViewModel, ProductsStates>(
        //   builder: (context, state) {
        //     final effectiveOccasions = occasions ?? state.occasionsState?.data;
        //     return OccasionPage(
        //       occasions: effectiveOccasions,
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
      title: Text((context).l10n.occasions),
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
