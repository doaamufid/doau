import 'package:doaa_eida_final_exam/Model/user_model.dart';
import 'package:doaa_eida_final_exam/helper/my_hive.dart';
import 'package:doaa_eida_final_exam/theme/MyTheme.dart';
import 'package:doaa_eida_final_exam/translations/LocalizationService.dart';
import 'package:doaa_eida_final_exam/views/BookingScreen.dart';
import 'package:doaa_eida_final_exam/views/HomeScreen.dart';
import 'package:doaa_eida_final_exam/views/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'controllers/home_binding.dart';
import 'helper/MyShared.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MyHive.init(adapters: (hive) {
    hive.registerAdapter(UserModelAdapter());
  });
  await MyShared.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.getThemeData(isLight: MyShared.getThemeMode()),
      translations: LocalizationService.getInstance(),
      locale: Locale(MyShared.getLocal()),
      initialRoute: "/LoginScreen",
      getPages: [
        GetPage(name: "/LoginScreen", page: () => LoginScreen()),
        GetPage(
          name: "/HomeScreen",
          page: () => HomeScreen(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: "/BookingScreen",
          page: () => BookingScreen(),
          binding: HomeBinding(),
        ),
      ],
    );
  }
}
