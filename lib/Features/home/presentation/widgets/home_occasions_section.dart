import 'package:flowers_app/Features/home/domain/entities/home_entities/occasion_entity.dart';
import 'package:flowers_app/Features/home/presentation/widgets/occasion_item.dart';
import 'package:flowers_app/Features/home/presentation/widgets/section_header.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeOccasionsSection extends StatelessWidget {
  final List<OccasionEntity> occasions;
  final double screenWidth;

  const HomeOccasionsSection({
    super.key,
    required this.occasions,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    const double figmaWidth = 375.0;
    final double productItemWidth = (screenWidth * (131 / figmaWidth)).clamp(
      120.0,
      180.0,
    );
    final double occasionItemWidth = productItemWidth;
    final double productListHeight = productItemWidth * 1.6;

    if (occasions.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SectionHeader(
          title: context.l10n.occasion,
          onViewAllTap: () {
         context.pushNamed(
              Routes.occasionName,
              extra: {
                'occasions': occasions,
                'initialIndex': 0, 
              },
            );
          },
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: productListHeight * 0.9,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: occasions.length,
            separatorBuilder: (context, index) =>
                SizedBox(width: screenWidth * 0.04),
            itemBuilder: (context, index) {
              final occasion = occasions[index];
              return GestureDetector(
                onTap: () {
                  final targetIndex = index;
                  context.pushNamed(Routes.occasionName, extra: {
                    'occasions': occasions,
                    'initialIndex': targetIndex,
                  });
                },
                child: OccasionItem(
                  title: occasion.name,
                  imageUrl: occasion.imageUrl,
                  width: occasionItemWidth,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}