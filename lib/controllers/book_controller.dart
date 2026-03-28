import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Model/hall_model.dart';
import 'hall_controller.dart';

class BookingController extends GetxController {
  var bookedHalls = <HallModel>[].obs;
  var totalValue = 0.0.obs;
  var originalTotal = 0.0.obs;
  var discount = 0.0.obs;

  final couponController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    updateBookingList();
  }

  void updateBookingList() {
    final hallController = Get.find<HallController>();
    bookedHalls.assignAll(hallController.halls.where((h) => h.isBooked).toList());
    calculateTotal();
  }

  void calculateTotal() {
    originalTotal.value = bookedHalls.fold(0, (sum, item) => sum + item.price);
    totalValue.value = originalTotal.value - discount.value;
    update();
  }

  void removeBooking(int index) {
    bookedHalls[index].isBooked = false;
    Get.find<HallController>().bookedCount.value--;
    Get.find<HallController>().halls.refresh();

    bookedHalls.removeAt(index);
    calculateTotal();
  }

  void checkCoupon() {
    if (couponController.text == "12345") {
      discount.value = 50.0;
    } else {
      discount.value = 0.0;
    }
    calculateTotal();
  }
}