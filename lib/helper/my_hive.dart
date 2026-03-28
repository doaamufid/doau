
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../Model/user_model.dart';

class MyHive{
  MyHive._();
   static late Box<UserModel> _userBox;
   static const String _userBoxName="userBox";

   static Future<void> init({Function (HiveInterface)? adapters})async{
    await Hive.initFlutter();
     adapters?.call(Hive);
     await initBoxes();
   }
   static Future<void> initBoxes() async{
     _userBox = await Hive.openBox(_userBoxName);
   }
 static Future<bool> saveUserModel(UserModel user) async{
     try{
       await _userBox.put(_userBoxName, user);
       return true;
     }catch(_){
       return false;
     }
 }
static UserModel? getCurrentUser(){
     try{
       return _userBox.get(_userBoxName);
     }catch(_){
       return null;
     }
}
static Future<bool> deleteUser() async{
     try{
       await _userBox.delete(_userBoxName);
       return true;
     }catch(_){
       return false;
     }
}
}