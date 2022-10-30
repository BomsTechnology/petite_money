import 'package:flutter/material.dart';

class MyThemes {
  static ThemeData themeData(bool isDarkMode, BuildContext context) {
    return ThemeData(
      textTheme: TextTheme(
        headline6: const TextStyle(
          color: Color(0xff263238),
        ),
        headline1: TextStyle(
          color: isDarkMode ? Colors.white : const Color(0xff263238),
        ),
        headline2: TextStyle(
          color: isDarkMode ? Colors.white : const Color(0xff263238),
        ),
        bodyText2: TextStyle(
          color: isDarkMode ? Colors.white : const Color(0xff263238),
        ),
        bodyText1: TextStyle(
          color: isDarkMode ? Colors.white : const Color(0xff263238),
        ),
        subtitle1: const TextStyle(
          color: Color(0xff263238),
        ),
      ),
      scaffoldBackgroundColor:
          isDarkMode ? const Color(0xFF00001a) : Colors.white,
      primaryColor: const Color(0xFF00b894),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.all(13)),
            backgroundColor:
                MaterialStateProperty.all<Color>(const Color(0xFF00b894))),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.all(10),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: isDarkMode ? Colors.white : const Color(0xff263238),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: isDarkMode ? Colors.white : const Color(0xFF00b894)),
      bottomAppBarTheme: BottomAppBarTheme(
        color: isDarkMode ? const Color(0xFF00b894) : Colors.white,
      ),
      colorScheme: ThemeData().colorScheme.copyWith(
            secondary:
                isDarkMode ? const Color(0xFF1a1f3c) : const Color(0xFFE8FDFD),
            brightness: isDarkMode ? Brightness.dark : Brightness.light,
            onBackground: const Color(0xFF00b894),
            primary: const Color(0xFF00b894),
          ),
      cardColor: isDarkMode ? const Color(0xFF0a002c) : const Color(0xFFE8FDFD),
      canvasColor: isDarkMode ? Colors.black : Colors.grey[50],
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme: isDarkMode
                ? const ColorScheme.dark()
                : const ColorScheme.light(),
          ),
    );
  }
}
