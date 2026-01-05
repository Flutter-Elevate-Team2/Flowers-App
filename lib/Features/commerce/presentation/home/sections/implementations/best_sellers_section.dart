import 'package:flowers_app/Features/commerce/domain/entities/home_entities/home_entity.dart';
import 'package:flowers_app/Features/commerce/presentation/home/sections/home_section.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/sections/home_best_sellers_section.dart';
import 'package:flutter/material.dart';

class BestSellersSection extends HomeSection {
  @override
  HomeSectionType get type => HomeSectionType.bestSellers;

  @override
  bool isVisible(HomeEntity data) => data.bestSellers.isNotEmpty;

  @override
  Widget build(BuildContext context, HomeEntity data) {
    final screenWidth = MediaQuery.of(context).size.width;
    return HomeBestSellersSection(
      bestSellers: data.bestSellers,
      screenWidth: screenWidth,
    );
  }
}
