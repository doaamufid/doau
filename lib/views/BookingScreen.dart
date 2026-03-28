import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/book_controller.dart';

class BookingScreen extends GetView<BookingController> {
  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF413DA2);
    const Color iconBgColor = Color(0xFFF6F7FB);

    return Scaffold(
      backgroundColor: Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text("Booking"),
        backgroundColor: primaryColor,
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () => _showSettingsPopup(context))
        ],
      ),
      body: GetBuilder<BookingController>(
        builder: (_) => Column(
          children: [
            Container(
              color: const Color(0xFF2D2D2D),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(5)),
                    child: Text(controller.bookedHalls.length.toString().padLeft(2, '0'),
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 15),
                  const Text("Your Cart\nitems added", style: TextStyle(color: Colors.white, fontSize: 12, height: 1.2)),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: controller.bookedHalls.length,
                itemBuilder: (context, index) {
                  final hall = controller.bookedHalls[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(hall.image, width: 100, height: 80, fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(hall.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black)),
                              const Text("HALLS CATEGORY", style: TextStyle(color: Color(0xFFAF8344), fontSize: 10, fontWeight: FontWeight.bold)),
                              Text(hall.location, style: const TextStyle(color: Colors.black, fontSize: 11)),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  _buildActionIcon(Icons.delete_outline, Colors.red, iconBgColor, () => controller.removeBooking(index)),
                                  const SizedBox(width: 10),
                                  _buildActionIcon(Icons.edit_outlined, Colors.grey, iconBgColor, () {}),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(4)),
                          child: Text("${hall.price.toInt()} SR", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomPaint(
                painter: DashedPainter(),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: controller.couponController,
                    onChanged: (_) => controller.checkCoupon(),
                    decoration: const InputDecoration(
                      hintText: "Set code",
                      border: InputBorder.none,
                      suffixText: "12345",
                      suffixStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Total Order Value", style: TextStyle(color: Colors.grey, fontSize: 13)),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text("${controller.totalValue.toInt()} SR", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
                      const SizedBox(width: 10),
                      if (controller.discount.value > 0)
                        Text("${controller.originalTotal.toInt()} SR",
                            style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey, fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, Color color, Color bg, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(5)),
        child: Icon(icon, color: color, size: 18),
      ),
    );
  }
  void _showSettingsPopup(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Settings", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text("Change Language"),
              onTap: () {
                Get.updateLocale(Get.locale?.languageCode == 'ar' ? const Locale('en') : const Locale('ar'));
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text("Dark / Light Mode"),
              onTap: () {
                Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DashedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.grey.shade300..style = PaintingStyle.stroke..strokeWidth = 1;
    var path = Path()..addRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), const Radius.circular(5)));
    canvas.drawPath(path, paint);
  }
  @override bool shouldRepaint(CustomPainter oldDelegate) => false;
}