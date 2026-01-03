import 'package:flowers_app/Features/home/domain/entities/home_entities/home_entity.dart';
import 'package:flowers_app/Features/home/presentation/sections/home_section.dart';
import 'package:flowers_app/Features/home/presentation/widgets/home_occasions_section.dart';
import 'package:flutter/material.dart';

class OccasionsSection extends HomeSection {
  @override
  HomeSectionType get type => HomeSectionType.occasions;

  @override
  bool isVisible(HomeEntity data) => data.occasions.isNotEmpty;

  @override
  Widget build(BuildContext context, HomeEntity data) {
    final screenWidth = MediaQuery.of(context).size.width;
    return HomeOccasionsSection(
      occasions: data.occasions,
      screenWidth: screenWidth,
    );
  }
}
