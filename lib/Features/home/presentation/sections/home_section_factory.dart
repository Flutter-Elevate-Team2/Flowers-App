import 'package:flowers_app/Features/home/domain/entities/home_entities/home_entity.dart';
import 'package:flowers_app/Features/home/presentation/sections/home_section.dart';
import 'package:flowers_app/Features/home/presentation/sections/implementations/best_sellers_section.dart';
import 'package:flowers_app/Features/home/presentation/sections/implementations/categories_section.dart';
import 'package:flowers_app/Features/home/presentation/sections/implementations/header_section.dart';
import 'package:flowers_app/Features/home/presentation/sections/implementations/occasions_section.dart';
import 'package:flutter/material.dart';

class HomeSectionFactory {
  final Map<HomeSectionType, HomeSection> _registry;

  HomeSectionFactory()
    : _registry = {
        HomeSectionType.header: HeaderSection(),
        HomeSectionType.categories: CategoriesSection(),
        HomeSectionType.bestSellers: BestSellersSection(),
        HomeSectionType.occasions: OccasionsSection(),
      };

  List<Widget> getSections({
    required HomeEntity data,
    required BuildContext context,
    List<HomeSectionType>? order,
  }) {
    final List<HomeSectionType> effectiveOrder =
        order ??
        [
          HomeSectionType.header,
          HomeSectionType.categories,
          HomeSectionType.bestSellers,
          HomeSectionType.occasions,
        ];

    final List<Widget> widgets = [];

    for (var type in effectiveOrder) {
      final section = _registry[type];
      if (section != null && section.isVisible(data)) {
        widgets.add(section.build(context, data));
      }
    }

    return widgets;
  }
}
