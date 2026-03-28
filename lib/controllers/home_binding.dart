import 'package:get/get.dart';
import '../controllers/hall_controller.dart';
import '../controllers/book_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HallController>(() => HallController());
    Get.lazyPut<BookingController>(() => BookingController());
  }
}