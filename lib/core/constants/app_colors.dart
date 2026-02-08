import 'package:flutter/material.dart';

abstract class AppColors {
  static MaterialColor white = const MaterialColor(0xFFF9F9F9, <int, Color>{
    10: Color(0xFFFFFFFF),
    20: Color(0xFFfdfdfd),
    30: Color(0xFFfcfcfc),
    40: Color(0xFFfbfbfb),
    50: Color(0xFFfafafa),
    60: Color(0xFFd0d0d0),
    70: Color(0xFFa6a6a6),
    80: Color(0xFF7d7d7d),
    90: Color(0xFF535353),
    100: Color(0xFF323232),
  });

  static MaterialColor mainColor = const MaterialColor(0xFFD21E6A, <int, Color>{
    10: Color(0xFFf6d2e1),
    20: Color(0xFFf0b4cd),
    30: Color(0xFFe98fb5),
    40: Color(0xFFe1699c),
    50: Color(0xFFda4483),
    60: Color(0xFFaf1958),
    70: Color(0xFF8c1447),
    80: Color(0xFF690f35),
    90: Color(0xFF460a23),
    100: Color(0xFF2a0615),
  });

  static MaterialColor black = const MaterialColor(0xFF0C1015, <int, Color>{
    10: Color(0xFFcecfd0),
    20: Color(0xFFAEAFB1),
    30: Color(0xFF86888a),
    40: Color(0xFF5d6063),
    50: Color(0xFF34383c),
    60: Color(0xFF0a0d12),
    70: Color(0xFF080b0e),
    80: Color(0xFF06080b),
    90: Color(0xFF040507),
    100: Color(0xFF020304),
  });

  static const Color gray = Color(0xFF535353);
  static const Color red = Color(0xffCC1010);
  static const Color green = Color(0xFF0CB359);
  static const Color lightPink = Color(0xFFF9ECF0);
  static const Color lightGray = Color(0xFFEAEAEA);

  // OTP Input Colors
  static const Color otpDisabledBackground = Color(0xFFF5F5F5);
  static const Color otpDisabledBorder = Color(0xFFE0E0E0);
  static const Color otpErrorBorder = Color(0xFFE53935);
  static const Color otpErrorText = Color(0xFFE53935);
}
