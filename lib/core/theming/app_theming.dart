import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/constants/constant_keys.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.white,
    fontFamily: ConstKeys.interFont,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.mainColor,
      onPrimary: AppColors.white,
      secondary: AppColors.black,
      onSecondary: AppColors.white,
      error: AppColors.red,
      onError: AppColors.white,
      surface: AppColors.white,
      onSurface: AppColors.mainColor,
    ),
    textTheme: TextTheme(
      bodySmall: getTextStyle(),
      bodyMedium: getTextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      bodyLarge: getTextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      headlineMedium: getTextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      titleTextStyle: getTextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      iconTheme: IconThemeData(color: AppColors.black),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      contentPadding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
      hintStyle: getTextStyle(
        color: AppColors.white[70],
        fontFamily: ConstKeys.robotoFont,
        fontWeight: FontWeight.w400,
      ),
      labelStyle: getTextStyle(
        color: AppColors.gray,
        fontFamily: ConstKeys.robotoFont,
        fontWeight: FontWeight.w400,
      ),
      floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
        if (states.contains(WidgetState.error)) {
          return getTextStyle(color: AppColors.red);
        }
        return getTextStyle(color: AppColors.gray);
      }),
      errorStyle: getTextStyle(color: AppColors.red),
      border: getOutlineInputBorder(color: AppColors.gray),
      focusedBorder: getOutlineInputBorder(color: AppColors.gray),
      enabledBorder: getOutlineInputBorder(color: AppColors.gray),
      errorBorder: getOutlineInputBorder(color: AppColors.red),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(
        color: AppColors.red,
        applyTextScaling: true,
      ),
      selectedItemColor: AppColors.red,
      unselectedItemColor: AppColors.gray,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.shifting,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.mainColor,
        disabledBackgroundColor: AppColors.black[30],
        foregroundColor: AppColors.white,
        textStyle: getTextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
    ),

    dialogTheme: DialogThemeData(
      titleTextStyle: getTextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      contentTextStyle: getTextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
  );

  static InputBorder getOutlineInputBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: color, width: 1),
    );
  }

  static TextStyle getTextStyle({
    Color? color,
    double? fontSize,
    String? fontFamily,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      color: color ?? AppColors.black,
      fontSize: fontSize ?? 14,
      fontFamily: fontFamily ?? ConstKeys.interFont,
      fontWeight: fontWeight ?? FontWeight.w400,
    );
  }
}
