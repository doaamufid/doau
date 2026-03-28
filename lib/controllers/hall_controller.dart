import 'package:get/get.dart';
import '../Model/hall_model.dart';
import '../helper/my_hive.dart';

class HallController extends GetxController {
  var halls = <HallModel>[
    HallModel(name: "New Music Event on Dubai Botek for Valentine Day", image: "assets/image.png", location: "Riyadh, Marash Tower", rating: 4.8, price: 1000.0),
    HallModel(name: " Dubai Botek for Valentine Day", image: "assets/image.png", location: "Riyadh, Marash Tower", rating: 4.5, price: 1500.0),
    HallModel(name: "New Music Event on Dubai Botek for Valentine Day", image: "assets/image.png", location: "Riyadh, Marash Tower", rating: 4.2, price: 1000.0),
  ].obs;

  var bookedCount = 0.obs;

  String welcomeName = "";

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() {
    var user = MyHive.getCurrentUser();
    welcomeName = user?.name ?? "User";
    bookedCount.value = halls.where((h) => h.isBooked).length;
    update();
  }

  void toggleBooking(int index) {
    bool isGuest = Get.arguments?['isGuest'] ?? false;

    if (isGuest) {
      Get.offAllNamed("/LoginScreen");
      Get.snackbar("تنبيه", "يجب تسجيل الدخول أولاً للتمكن من الحجز");
      return;
    }

    halls[index].isBooked = !halls[index].isBooked;

    bookedCount.value = halls.where((h) => h.isBooked).length;

    halls.refresh();
  }
}