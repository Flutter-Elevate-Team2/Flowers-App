import 'package:flowers_app/Features/home/domain/entities/home_entities/home_entity.dart';
import 'package:flowers_app/Features/home/presentation/view_model/home_events.dart';
import 'package:flowers_app/Features/home/presentation/view_model/home_view_model.dart';
import 'package:flowers_app/Features/home/presentation/widgets/home_best_sellers_section.dart';
import 'package:flowers_app/Features/home/presentation/widgets/home_categories_section.dart';
import 'package:flowers_app/Features/home/presentation/widgets/home_header.dart';
import 'package:flowers_app/Features/home/presentation/widgets/home_occasions_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeContentWidget extends StatelessWidget {
  final HomeEntity homeData;

  const HomeContentWidget({super.key, required this.homeData});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;
        final double screenHeight = constraints.maxHeight;

        return SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<HomeViewModel>().doIntent(GetHomeDataEvent());
            },
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
                        HomeCategoriesSection(
                          categories: homeData.categories,
                          screenWidth: screenWidth,
                        ),
                        if (homeData.categories.isNotEmpty)
                          const Spacer(flex: 2),

                        // --- Best Seller Section ---
                        HomeBestSellersSection(
                          bestSellers: homeData.bestSellers,
                          screenWidth: screenWidth,
                        ),
                        if (homeData.bestSellers.isNotEmpty)
                          const Spacer(flex: 2),

                        // --- Occasions Section ---
                        HomeOccasionsSection(
                          occasions: homeData.occasions,
                          screenWidth: screenWidth,
                        ),

                        const Spacer(flex: 1),
                      ],
                    ),
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
