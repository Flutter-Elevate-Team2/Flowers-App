import 'package:flowers_app/Features/commerce/domain/entities/home_entities/home_entity.dart';
import 'package:flowers_app/Features/commerce/presentation/home/sections/home_section.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/sections/home_categories_section.dart';
import 'package:flutter/material.dart';

class CategoriesSection extends HomeSection {
  @override
  HomeSectionType get type => HomeSectionType.categories;

  @override
  bool isVisible(HomeEntity data) => data.categories.isNotEmpty;

  @override
  Widget build(BuildContext context, HomeEntity data) {
    final screenWidth = MediaQuery.of(context).size.width;

    return HomeCategoriesSection(
      categories: data.categories,
      screenWidth: screenWidth,
    );
  }
}
