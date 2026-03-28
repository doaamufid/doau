import 'package:flutter/material.dart';
import 'LightThemeColors.dart';
import 'DarkThemeColors.dart';

class MyTheme {
  static ThemeData getThemeData({required bool isLight}) {
    final Color color=isLight ? LightThemeColors.text : DarkThemeColors.text;
    return ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  isLight ? LightThemeColors.primary : DarkThemeColors.primary),
              foregroundColor: MaterialStateProperty.all<Color>(
                  isLight ? LightThemeColors.text : DarkThemeColors.text),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              maximumSize: MaterialStateProperty.all<Size>(
                  Size(300, 300)),
              padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(vertical: 10, horizontal: 20)))),
      textTheme: TextTheme(
        bodyMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,color: color),
        bodySmall: TextStyle(
            fontSize: 10,
            color: color),
        bodyLarge: TextStyle(
            fontSize: 20,
            color: color),
      ),
    );
  }
}
