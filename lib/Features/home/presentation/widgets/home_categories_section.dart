import 'package:flowers_app/Features/home/domain/entities/home_entities/category_entity.dart';
import 'package:flowers_app/Features/home/presentation/widgets/category_item.dart';
import 'package:flowers_app/Features/home/presentation/widgets/section_header.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeCategoriesSection extends StatelessWidget {
  final List<CategoryEntity> categories;
  final double screenWidth;

  const HomeCategoriesSection({
    super.key,
    required this.categories,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    const double figmaWidth = 375.0;
    final double categoryBoxSize = (screenWidth * (68 / figmaWidth)).clamp(
      60.0,
      100.0,
    );
    final double categoryListHeight = categoryBoxSize * 1.4;

    if (categories.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SectionHeader(
          title: context.l10n.categories,
          onViewAllTap: () {
            context.goNamed(
              Routes.categoriesName,
              extra: {
                'categories': categories,
                'initialIndex': 0, // 0 for 'All'
              },
            );
          },
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: categoryListHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: categories.length,
            separatorBuilder: (context, index) =>
                SizedBox(width: screenWidth * 0.04),
            itemBuilder: (context, index) {
              final category = categories[index];
              return CategoryItem(
                title: category.name,
                imageUrl: category.icon,
                boxSize: categoryBoxSize,
                onTap: () {
                  // +1 because index 0 is "All" in CategoriesPage
                  final targetIndex = index + 1;
                  context.goNamed(
                    Routes.categoriesName,
                    extra: {
                      'categories': categories,
                      'initialIndex': targetIndex,
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}