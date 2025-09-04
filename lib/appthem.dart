import 'package:flutter/material.dart';

class Appthem {
  static const primary = Color(0xff200E32);
  static const backgroundlight = Color(0xff5D9CEC);
  static const backgrounddark = Color(0xff200E32);

  static const green = Color(0xff61E757);
  static const red = Color(0xffEC4B4B);
  static const white = Color(0xffffffff);

  static ThemeData lightthem = ThemeData(
    timePickerTheme: const TimePickerThemeData(),
    datePickerTheme: const DatePickerThemeData(
      shadowColor: Appthem.primary,
      dividerColor: Appthem.green,
      backgroundColor: Appthem.red,
      dayOverlayColor: WidgetStatePropertyAll(Appthem.backgroundlight),
    ),
    primaryColor: backgroundlight,
    scaffoldBackgroundColor: backgroundlight,
    appBarTheme: const AppBarTheme(backgroundColor: primary),
    // iconButtonTheme: IconButtonThemeData(
    //   style: ButtonStyle(
    //     textStyle: WidgetStatePropertyAll(TextStyle(color: primary))
    //   )
    // ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Appthem.primary,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: white,
    ),

    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: white),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(),

    bottomAppBarTheme: const BottomAppBarTheme(
      padding: EdgeInsets.zero,
      shape: CircularNotchedRectangle(),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        
      ),
    ),
  );
  static ThemeData darkthem = ThemeData(
    primaryColor: backgrounddark,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: primary, fontSize: 24),
      backgroundColor: backgrounddark,
    ),
    // iconButtonTheme: IconButtonThemeData(
    //   style: ButtonStyle(
    //     textStyle: WidgetStatePropertyAll(TextStyle(color: primary))
    //   )
    // ),
    scaffoldBackgroundColor: backgrounddark,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Appthem.primary,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: backgrounddark,
    ),
    inputDecorationTheme: const InputDecorationTheme(),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      shape: CircleBorder(side: BorderSide(width: 4, color: backgrounddark)),
      backgroundColor: primary,
      foregroundColor: backgrounddark,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      padding: EdgeInsets.zero,
      shape: CircularNotchedRectangle(),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Appthem.white,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Appthem.white,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Appthem.white,
      ),
    ),
  );
}
