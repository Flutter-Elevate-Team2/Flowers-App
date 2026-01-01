import 'package:flowers_app/Features/home/domain/entities/home_entities/home_entity.dart';
import 'package:flutter/material.dart';

enum HomeSectionType { categories, header, bestSellers, occasions }

abstract class HomeSection {
  HomeSectionType get type;

  bool isVisible(HomeEntity data);

  Widget build(BuildContext context, HomeEntity data);
}
