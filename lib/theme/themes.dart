import 'package:flutter/material.dart';
import 'package:unier/utils/colors.dart';

class Themes {
  static ThemeData getLightTheme() {
    return ThemeData(
      textTheme: TextTheme(
        bodyLarge: TextStyle(
            fontSize: 30),
        labelMedium: TextStyle(
            fontSize: 24),
      ),
      colorScheme: const ColorScheme.light(
        primary: AppColors.hondaBlue,
        onPrimary: Colors.white,
        secondary: AppColors.hondaRed,
        error: Color(0xFDFF0000),
        onError: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        toolbarHeight: 56,
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 24),
      ),
      brightness: Brightness.light,
      iconTheme: const IconThemeData(color: AppColors.hondaBlue),
      inputDecorationTheme: const InputDecorationTheme(
        iconColor: AppColors.hondaBlue,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.hondaBlue, width: 2),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black54),
          // borderSide: BorderSide(color: Colors.white60),
        ),
        suffixIconColor: AppColors.hondaRed,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.hondaBlue,
          elevation: 2,
          foregroundColor: AppColors.hondaRed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
            // side: BorderSide(width: UiSizes.width_1, color: Colors.black),
          ),
          minimumSize: const Size.fromHeight(45), // NEW
        ),
      ),
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.bgBlackColor,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.hondaRed,
        secondary: AppColors.hondaBlue,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        surface: Color.fromRGBO(17, 17, 20, 1),
        onSurface: AppColors.hondaRed,
        error: Color(0xFDFF0000),
        onError: Colors.white,
      ),
      textTheme: TextTheme(
        titleMedium: TextStyle(
            fontSize: 30),
        labelLarge: TextStyle(
            fontSize: 18),
        bodyMedium: TextStyle(
            fontSize: 18),
        bodyLarge: TextStyle(
            fontSize: 20),
        labelMedium: TextStyle(
            fontSize: 18),
      ),
      appBarTheme: const AppBarTheme(
        foregroundColor: AppColors.hondaRed,
        toolbarHeight: 56,
        elevation: 0,
        titleTextStyle: TextStyle(
            color: AppColors.hondaRed,
            fontWeight: FontWeight.w500,
            fontSize: 24),
      ),
      iconTheme: const IconThemeData(color: AppColors.hondaRed),
      inputDecorationTheme: const InputDecorationTheme(
        iconColor: AppColors.hondaRed,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.hondaRed, width: 2),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white60),
        ),
        suffixIconColor: AppColors.hondaBlue,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.hondaRed,
          foregroundColor: Colors.black,
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // <-- Radius
              side: BorderSide(width: 1, color: Colors.grey[800]!)),
          minimumSize: const Size.fromHeight(45), // NEW
        ),
      ),
    );
  }
}
