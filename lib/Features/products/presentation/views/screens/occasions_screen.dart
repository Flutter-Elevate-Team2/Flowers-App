import 'package:flowers_app/Features/home/domain/entities/home_entities/occasion_entity.dart';
import 'package:flowers_app/Features/products/presentation/view_model/products_events.dart';
import 'package:flowers_app/Features/products/presentation/view_model/products_states.dart';
import 'package:flowers_app/Features/products/presentation/view_model/products_view_model.dart';
import 'package:flowers_app/Features/products/presentation/widgets/occasion_page.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/di/di.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OccasionsScreen extends StatelessWidget {
  final List<OccasionEntity>? occasions;
  final int initialIndex;

  const OccasionsScreen({
    super.key,
    this.occasions,
    this.initialIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios),
          onTap: () {
            context.pop();
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
             context.l10n.occasion,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              context.l10n.occasionDescription,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.gray),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: BlocProvider(
        key: ValueKey(initialIndex),
        create: (context) {
          final viewModel = getIt<ProductsViewModel>();

          if (occasions != null && occasions!.isNotEmpty && initialIndex < occasions!.length) {
            viewModel.doIntent(FetchProductsEvent(occasionId: occasions![initialIndex].id));
          } else {
            viewModel.doIntent(FetchProductsEvent());
          }

          if (occasions == null) {
            viewModel.doIntent(FetchOccasionsEvent());
          }
          return viewModel;
        },
        child: BlocBuilder<ProductsViewModel, ProductsStates>(
          builder: (context, state) {
            final effectiveOccasions = occasions ?? state.occasionsState?.data;
            return OccasionPage(
              key: ValueKey(initialIndex),
              occasions: effectiveOccasions,
              initialIndex: initialIndex,
            );
          },
        ),
      ),
    );
  }
}