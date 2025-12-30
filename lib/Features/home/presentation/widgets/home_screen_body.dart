import 'package:flowers_app/Features/home/presentation/view_model/home_events.dart';
import 'package:flowers_app/Features/home/presentation/view_model/home_states.dart';
import 'package:flowers_app/Features/home/presentation/view_model/home_view_model.dart';
import 'package:flowers_app/Features/home/presentation/widgets/category_item.dart';
import 'package:flowers_app/Features/home/presentation/widgets/home_header.dart';
import 'package:flowers_app/Features/home/presentation/widgets/home_shimmer_loading.dart';
import 'package:flowers_app/Features/home/presentation/widgets/occasion_item.dart';
import 'package:flowers_app/Features/home/presentation/widgets/product_item.dart';
import 'package:flowers_app/Features/home/presentation/widgets/section_header.dart';
import 'package:flowers_app/core/di/di.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowers_app/Features/home/domain/entities/home_entities/home_entity.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeViewModel>(),
      child: BlocBuilder<HomeViewModel, HomeStates>(
        builder: (context, state) {
          final homeState = state.homeState;

          if (homeState?.isLoading == true) {
            return const Center(child: HomeShimmerLoading());
          }

          if (homeState?.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(homeState!.errorMessage!),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      context.read<HomeViewModel>().doIntent(GetHomeDataEvent());
                    },
                    child: const Text("Retry"),
                  )
                ],
              ),
            );
          }

          final homeData = homeState?.data;

          if (homeData != null) {
            return _buildContent(context, homeData);
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, HomeEntity homeData) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;
        final double screenHeight = constraints.maxHeight;

        const double figmaWidth = 375.0;

        final double categoryBoxSize = (screenWidth * (68 / figmaWidth)).clamp(60.0, 100.0);
        final double productItemWidth = (screenWidth * (131 / figmaWidth)).clamp(120.0, 180.0);
        final double occasionItemWidth = productItemWidth;

        final double categoryListHeight = categoryBoxSize * 1.4;
        final double productListHeight = productItemWidth * 1.6;

        return SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: screenHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Header ---
                      const HomeHeader(),

                      const Spacer(flex: 1),

                      // --- Categories Section ---
                      if (homeData.categories.isNotEmpty) ...[
                        SectionHeader(
                          title: context.l10n.categories,
                          onViewAllTap: () {
                             // Navigate to Categories Screen
                          },
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: categoryListHeight,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: homeData.categories.length,
                            separatorBuilder: (context, index) => SizedBox(width: screenWidth * 0.04),
                            itemBuilder: (context, index) {
                              final category = homeData.categories[index];
                              return CategoryItem(
                                title: category.name,
                                imageUrl: category.icon,
                                boxSize: categoryBoxSize,
                              );
                            },
                          ),
                        ),
                        const Spacer(flex: 2),
                      ],

                      // --- Best Seller Section ---
                      if (homeData.bestSellers.isNotEmpty) ...[
                        SectionHeader(
                          title: context.l10n.bestSeller,
                          onViewAllTap: () {},
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: productListHeight,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: homeData.bestSellers.length,
                            separatorBuilder: (context, index) => SizedBox(width: screenWidth * 0.04),
                            itemBuilder: (context, index) {
                              final product = homeData.bestSellers[index];
                              return ProductItem(
                                name: product.name,
                                price: product.price.toString(),
                                imageUrl: product.imageUrl,
                                width: productItemWidth,
                              );
                            },
                          ),
                        ),
                        const Spacer(flex: 2),
                      ],

                      // --- Occasions Section ---
                      if (homeData.occasions.isNotEmpty) ...[
                        SectionHeader(
                          title: context.l10n.occasion,
                          onViewAllTap: () {},
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: productListHeight * 0.9,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: homeData.occasions.length,
                            separatorBuilder: (context, index) => SizedBox(width: screenWidth * 0.04),
                            itemBuilder: (context, index) {
                              final occasion = homeData.occasions[index];
                              return OccasionItem(
                                title: occasion.name,
                                imageUrl: occasion.imageUrl,
                                width: occasionItemWidth,
                              );
                            },
                          ),
                        ),
                      ],

                      const Spacer(flex: 1),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
