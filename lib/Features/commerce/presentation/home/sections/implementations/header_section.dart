import 'package:flowers_app/Features/commerce/domain/entities/home_entities/home_entity.dart';
import 'package:flowers_app/Features/commerce/presentation/home/sections/home_section.dart';
import 'package:flowers_app/Features/commerce/presentation/home/widgets/sections/home_header.dart';
import 'package:flutter/material.dart';

class HeaderSection extends HomeSection {
  @override
  HomeSectionType get type => HomeSectionType.header;

  @override
  bool isVisible(HomeEntity data) => true;

  @override
  Widget build(BuildContext context, HomeEntity data) {
    return const HomeHeader();
  }
}
