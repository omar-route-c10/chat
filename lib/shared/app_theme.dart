import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF5D9CEC);
  static const Color blackColor = Color(0xFF141922);
  static const Color greyColor = Color(0xFF7F7F7F);
  static const Color lightGreyColor = Color.fromARGB(255, 237, 237, 237);
  static const Color whiteColor = Color(0xFFFFFFFF);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        color: whiteColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      centerTitle: true,
      foregroundColor: whiteColor,
    ),
    scaffoldBackgroundColor: whiteColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: whiteColor,
      shape: CircleBorder(),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
        foregroundColor: AppTheme.blackColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: greyColor,
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: greyColor.withOpacity(0.8),
          width: 1,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: primaryColor,
          width: 2,
        ),
      ),
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: blackColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: blackColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: blackColor,
      ),
      bodySmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: blackColor,
      ),
      displaySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: blackColor,
      ),
    ),
  );
}
