import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

 class MyShared {
  static late SharedPreferences preferences;
  static final String themeMode = "themeMode";
  static final String _local = "Local";

  static init() async {
    preferences = await SharedPreferences.getInstance();
  }

 static getThemeMode() {
    return preferences.getBool(themeMode) ?? true;
  }
 static setThemeMode(bool isLight) async {
    await preferences.setBool(themeMode, isLight);
  }
  static getLocal() {
    return preferences.getString(_local) ?? "ar";
  }
  static setLocal(String local) async {
    await preferences.setString(_local, local);
  }
}
