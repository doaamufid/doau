import 'package:doaa_eida_final_exam/FirstScreen.dart';
import 'package:doaa_eida_final_exam/Model/user_model.dart';
import 'package:doaa_eida_final_exam/helper/my_hive.dart';
import 'package:doaa_eida_final_exam/theme/MyTheme.dart';
import 'package:doaa_eida_final_exam/translations/LocalizationService.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'helper/MyShared.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();

  await MyHive.init(
    adapters: (hive){
      hive.registerAdapter(UserModelAdapter());
    }
  );
  await MyShared.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
//لتغيير اللغة LocalizationService.updateLanguage
  //ولاستخدام string هداك String.login.tr
  @override
  Widget build(BuildContext context) {
    return
      // MultiProvider(
      // providers: [
      //   // ChangeNotifierProvider(create: (_) => LoginProvider()),
      // ],
      GetMaterialApp(
        builder: (context, child) {
          return Theme(
              data: MyTheme.getThemeData(isLight: MyShared.getThemeMode()), child: child!);
        },
        translations:LocalizationService.getInstance(),
        locale:LocalizationService.defaultLanguage,
        initialRoute: "/FirstScreen",
        getPages: [
          GetPage(name: "/FirstScreen", page: () => FirstScreen()),
          // GetPage(name: "/SplashScreen", page: ()=> SplashScreen()),
          // GetPage(name: "/LoginScreen", page: ()=> LoginScreen()),
          // GetPage(name: "/theme", page: ()=> ThemeScreen()),
        ],
      );
  }
}


