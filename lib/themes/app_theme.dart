import 'package:flutter/material.dart';
import 'package:nutech_flutter_apps/resources/resources.dart';

class AppTheme {
  static ThemeData buildThemeData(bool darkMode) {
    return ThemeData(
      primaryColor: AppColors.colorPrimary,
      colorScheme: ThemeData().colorScheme.copyWith(
            primary: AppColors.colorPrimary,
            secondary: AppColors.colorSecondary,
          ),
      brightness: (darkMode) ? Brightness.light : Brightness.light,
      scaffoldBackgroundColor:
          (darkMode) ? AppColors.black : AppColors.white,
      backgroundColor:
          (darkMode) ? AppColors.black : AppColors.white,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      appBarTheme: (darkMode) ? darkAppBar() : lightAppBar(),
      fontFamily: 'avenir',
      floatingActionButtonTheme: const FloatingActionButtonThemeData(),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        primary: AppColors.colorPrimary,
      )),
      bottomNavigationBarTheme:
          (darkMode) ? darkNavigation() : lightNavigation(),
      textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.textColor,
        ), // Navbar
        headline2: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColors.textColor,
        ), // Banner
        headline3: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.textColor,
        ), // Normal
        headline4: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.textColor,
        ),
        headline5: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.textColor), // SubNormal
        headline6: TextStyle(
            fontSize: 14,
            color: AppColors.textColor,
            fontWeight: FontWeight.w500),
        bodyText1: const TextStyle(
            fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w400),
        bodyText2: const TextStyle(
            fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w400),
        button: const TextStyle(fontSize: 14, color: Colors.white),
      ),
      inputDecorationTheme: inputDecoration(darkMode),
    );
  }

  static AppBarTheme lightAppBar() {
    return const AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      color: Colors.white,
      elevation: 0,
    );
  }

  static BottomNavigationBarThemeData lightNavigation() {
    return const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.black,
      selectedItemColor: Colors.deepOrangeAccent,
      elevation: 0,
    );
  }

  static AppBarTheme darkAppBar() {
    return const AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
      color: Colors.black,
      elevation: 0,
    );
  }

  static BottomNavigationBarThemeData darkNavigation() {
    return const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.deepOrangeAccent,
      elevation: 0,
    );
  }

  // Box Field
  static inputDecoration(bool darkMode) {
    return InputDecorationTheme(
      filled: false,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 3),
      border: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.underlineColor)),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.underlineColor)),
      errorBorder: UnderlineInputBorder(
        borderSide:
            BorderSide(color: AppColors.red.withOpacity(0.8), width: 1),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.red, width: 1.4),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.colorPrimary, width: 1),
      ),
      labelStyle: TextStyle(
        color: darkMode ? AppColors.white : AppColors.black,
      ),
      hintStyle: TextStyle(
        color: AppColors.subHintColor,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
    );
  }
}
