import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constant/app_colors.dart';

enum AppTheme { light, dark }

final Map<AppTheme, ThemeData> kAppThemeData = {
  AppTheme.light: ThemeData.light().copyWith(
    primaryColor: blue,
    scaffoldBackgroundColor: white,
    canvasColor: white,
    splashColor: white.withOpacity(0.1),
    useMaterial3: true,
    bottomSheetTheme: const BottomSheetThemeData(
      elevation: 0,
      backgroundColor: white,
      surfaceTintColor: Colors.transparent,
      modalBackgroundColor: Colors.transparent,
    ),
    dialogTheme: const DialogTheme(
        backgroundColor: white,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent),
    textTheme: const TextTheme().copyWith(
      displayLarge: const TextStyle(
        fontSize: 40,
        fontFamily: 'Satoshi-Regular',
        color: black,
      ),
      displayMedium: const TextStyle(
        fontSize: 30,
        fontFamily: 'Satoshi-Regular',
        color: black,
      ),
      displaySmall: const TextStyle(
        fontSize: 24,
        fontFamily: 'Satoshi-Regular',
        color: black,
      ),
      headlineMedium: const TextStyle(
          fontSize: 20,
          fontFamily: 'Satoshi-Regular',
          color: black,
          fontWeight: FontWeight.bold),
      headlineSmall: const TextStyle(
        fontSize: 18,
        fontFamily: 'Satoshi-Regular',
        color: black,
      ),
      titleLarge: const TextStyle(
        fontSize: 16,
        fontFamily: 'Satoshi-Regular',
        color: black,
      ),
      bodyLarge: const TextStyle(
        fontSize: 18,
        fontFamily: 'Satoshi-Regular',
        color: black,
      ),
      bodyMedium: const TextStyle(
          fontSize: 14,
          fontFamily: 'Satoshi-Regular',
          color: black,
          fontWeight: FontWeight.normal),
      bodySmall: const TextStyle(
        fontSize: 12,
        fontFamily: 'Satoshi-Regular',
        color: black,
      ),
    ),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: Colors.black.withOpacity(0.5),
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
      elevation: 0,
      centerTitle: false,
      backgroundColor: white,
      titleTextStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'Satoshi-Regular',
        color: white,
      ),
      iconTheme: const IconThemeData(
        color: white,
      ),
      actionsIconTheme: const IconThemeData(
        color: white,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: white,
      selectedItemColor: black,
      selectedIconTheme: IconThemeData(
        color: blue,
        size: 24,
      ),
      elevation: 0,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
    ),
    timePickerTheme: const TimePickerThemeData(
      backgroundColor: white,
    ),
    colorScheme: const ColorScheme.light()
        .copyWith(
          background: white,
          surface: textColor,
          primary: blue,
          secondary: blue,
        )
        .copyWith(background: blue)
        .copyWith(error: redColor),
  ),
  AppTheme.dark: ThemeData.light().copyWith(
    primaryColor: white,
    scaffoldBackgroundColor: black,
    canvasColor: white,
    splashColor: white.withOpacity(0.1),
    useMaterial3: true,
    bottomSheetTheme: const BottomSheetThemeData(
      elevation: 0,
      backgroundColor: blue,
      surfaceTintColor: Colors.transparent,
      modalBackgroundColor: Colors.transparent,
    ),
    dialogTheme: const DialogTheme(
        backgroundColor: white,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent),
    textTheme: const TextTheme().copyWith(
      displayLarge: const TextStyle(
        fontSize: 40,
        fontFamily: 'SSatoshi-Bold',
        color: black,
      ),
      displayMedium: const TextStyle(
        fontSize: 30,
        fontFamily: 'Satoshi-Boldr',
        color: black,
      ),
      displaySmall: const TextStyle(
        fontSize: 25,
        fontFamily: 'Satoshi-Bold',
        color: black,
      ),
      headlineMedium: const TextStyle(
        fontSize: 20,
        fontFamily: 'Satoshi-Bold',
        color: black,
      ),
      headlineSmall: const TextStyle(
        fontSize: 18,
        fontFamily: 'Satoshi-Bold',
        color: black,
      ),
      titleLarge: const TextStyle(
        fontSize: 16,
        fontFamily: 'Satoshi-Bold',
        color: black,
      ),
      bodyLarge: const TextStyle(
        fontSize: 18,
        fontFamily: 'Satoshi-Bold',
        color: black,
      ),
      bodyMedium: const TextStyle(
        fontSize: 14,
        fontFamily: 'Satoshi-Bold',
        color: black,
      ),
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: white,

        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
      elevation: 0,
      centerTitle: false,
      backgroundColor: white,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'Satoshi-Regular',
        color: white,
      ),
      iconTheme: IconThemeData(
        color: white,
      ),
      actionsIconTheme: IconThemeData(
        color: white,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: white,
      selectedItemColor: white,
      selectedIconTheme: IconThemeData(
        color: white,
        size: 24,
      ),
      elevation: 0,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
    ),
    timePickerTheme: const TimePickerThemeData(
      backgroundColor: blue,
    ),
    colorScheme: const ColorScheme.light()
        .copyWith(
          background: white,
          surface: textColor,
          primary: blue,
          secondary: blue,
        )
        .copyWith(background: blue)
        .copyWith(error: redColor),
  ),
};
