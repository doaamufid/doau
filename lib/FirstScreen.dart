import 'package:doaa_eida_final_exam/theme/MyTheme.dart';
import 'package:doaa_eida_final_exam/translations/LocalizationService.dart';
import 'package:doaa_eida_final_exam/translations/stringsKey.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'helper/MyShared.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("data",style: theme.textTheme.bodyLarge,),
          Text("data",style: theme.textTheme.bodySmall,),
          Text("data",style: theme .textTheme.bodyMedium?.copyWith(color: Colors.orange,fontSize: 20),),
          ElevatedButton(onPressed: (){

          }, child: Text(Strings.login.tr)),
          ElevatedButton(onPressed: (){
            bool currentTheme = MyShared.getThemeMode();
            MyShared.setThemeMode(!currentTheme); // عكس الحالة وحفظها
            Get.changeTheme(MyTheme.getThemeData(isLight: !currentTheme));
          }, child: Text(Strings.signUp.tr)),
          ElevatedButton(onPressed: () async{
          await  LocalizationService.updateLanguage();
          Get.forceAppUpdate();
          }, child: Text("Change Languade"))
          ,Image.asset(
            'assets/unnamed.png',
            width: 135,
            height: 115.44,
            fit: BoxFit.contain,
            colorBlendMode: BlendMode.srcIn,
          ),
        ],
      ),
    );
  }
}
