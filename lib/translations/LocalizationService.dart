// import 'package:get/get.dart';
import 'dart:ui';

import 'package:doaa_eida_final_exam/helper/MyShared.dart';
import 'package:doaa_eida_final_exam/translations/ar/ar_su_translation.dart';
import 'package:doaa_eida_final_exam/translations/en/en_us_translation.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:get/route_manager.dart';

class LocalizationService extends Translations{
  static LocalizationService? _instance;
  static LocalizationService getInstance(){
    _instance ??=LocalizationService();
    return _instance!;
  }
  static Map<String,Locale> supportedLanguage={
    'en' :Locale('en'),
    'ar' :Locale('ar'),
  };
  static Locale defaultLanguage = supportedLanguage['ar']!;
  @override
  Map<String,Map<String,String>> get keys =>{
    'en':enUs,
    'ar':arSU,
  };
  static updateLanguage() async {
    String langCode = MyShared.getLocal();
    String newLang = (langCode == "ar") ? "en" : "ar";

    await MyShared.setLocal(newLang);
    Get.updateLocale(Locale(newLang));
  }
}