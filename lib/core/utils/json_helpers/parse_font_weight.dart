import 'dart:ui';

FontWeight parseFontWeight(String weight) {
  switch (weight) {
    case 'bold':
      return FontWeight.bold;
    case 'normal':
    default:
      return FontWeight.normal;
  }
}