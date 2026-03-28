import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Model/user_model.dart';
import '../helper/my_hive.dart';

class LoginController extends GetxController {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    String name = userNameController.text.trim();
    String pass = passwordController.text.trim();

    UserModel adminUser = UserModel(name: "admin", email: "123456789");
    await MyHive.saveUserModel(adminUser);

    UserModel? storedUser = MyHive.getCurrentUser();

    if (storedUser != null && name == storedUser.name && pass == storedUser.email) {

      Get.snackbar(
          "نجاح تسجيل الدخول",
          "أهلاً بك يا ${storedUser.name}",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM
      );

      Get.offNamed("/HomeScreen", arguments: {"isGuest": false});

    } else {
      Get.snackbar(
          "فشل تسجيل الدخول",
          "اسم المستخدم أو كلمة المرور غير صحيحة",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM
      );
    }
  }

  void skip() {
    Get.offNamed("/HomeScreen", arguments: {"isGuest": true});
  }

  @override
  void onClose() {
    userNameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}