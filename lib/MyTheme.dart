import 'package:flutter/material.dart';
import 'LightThemeColors.dart';
import 'DarkThemeColors.dart';

class MyTheme {
  static ThemeData getThemeData({required bool isLight}) {
    return ThemeData(
      brightness: isLight ? Brightness.light : Brightness.dark,
      primaryColor: isLight ? LightThemeColors.primary : DarkThemeColors.primary,
      scaffoldBackgroundColor: isLight ? LightThemeColors.background : DarkThemeColors.background,

      // هنا نخبر فلاتر كيف يعامل النصوص بشكل تلقائي
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: isLight ? LightThemeColors.text : DarkThemeColors.text),
      ),
    );
  }
}