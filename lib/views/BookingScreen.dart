import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/book_controller.dart';
import '../helper/MyShared.dart';
import '../translations/stringsKey.dart';

class BookingScreen extends GetView<BookingController> {
  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF413DA2);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(Strings.booking.tr),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showSettingsPopup(context),
          )
        ],
      ),
      body: Obx(() {
        Color iconBgColor = Get.isDarkMode ? Colors.grey[800]! : const Color(0xFFF6F7FB);
        Color textColor = Get.isDarkMode ? Colors.white : Colors.black;

        return Column(
          children: [
            Container(
              color: const Color(0xFF2D2D2D),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      controller.bookedHalls.length.toString().padLeft(2, '0'),
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Text(
                    "Your Cart\nitems added",
                    style: TextStyle(color: Colors.white, fontSize: 12, height: 1.2),
                  ),
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
                              Text(
                                hall.name,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: textColor),
                              ),
                              const Text(
                                "HALLS CATEGORY",
                                style: TextStyle(color: Color(0xFFAF8344), fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                hall.location,
                                style: TextStyle(color: Get.isDarkMode ? Colors.white70 : Colors.black, fontSize: 11),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  _buildActionIcon(Icons.delete_outline, Colors.red, iconBgColor, () => controller.removeBooking(index)),
                                  const SizedBox(width: 10),
                                  _buildActionIcon(Icons.edit_outlined, Colors.grey, iconBgColor, () {
                                    _showEditDialog(context, index, hall.name, hall.price);
                                  }),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(4)),
                          child: Text(
                            "${hall.price.toInt()} SR",
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
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
                    style: TextStyle(color: textColor),
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
                      Text(
                        "${controller.totalValue.toInt()} SR",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textColor),
                      ),
                      const SizedBox(width: 10),
                      if (controller.discount.value > 0)
                        Text(
                          "${controller.originalTotal.toInt()} SR",
                          style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey, fontSize: 14),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      }),
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
        decoration: BoxDecoration(
          color: Get.isDarkMode ? Colors.grey[900] : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(Strings.settings.tr, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.palette),
              title: Text(Strings.changeTheme.tr),
              trailing: Switch(
                value: Get.isDarkMode,
                onChanged: (value) {
                  Get.changeTheme(value ? ThemeData.dark() : ThemeData.light());
                  MyShared.setThemeMode(value);
                  Get.back();
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(Strings.changeLang.tr),
              onTap: () {
                Locale locale = Get.locale?.languageCode == 'ar' ? const Locale('en') : const Locale('ar');
                Get.updateLocale(locale);
                MyShared.setLocal(locale.languageCode);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, int index, String currentName, double currentPrice) {
    TextEditingController nameEditController = TextEditingController(text: currentName);
    TextEditingController priceEditController = TextEditingController(text: currentPrice.toString());

    Get.defaultDialog(
      title: "Edit Booking",
      backgroundColor: Get.isDarkMode ? Colors.grey[900] : Colors.white,
      titleStyle: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
      content: Column(
        children: [
          TextField(
            controller: nameEditController,
            style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
            decoration: const InputDecoration(labelText: "Hall Name"),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: priceEditController,
            keyboardType: TextInputType.number,
            style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
            decoration: const InputDecoration(labelText: "Price (SR)"),
          ),
        ],
      ),
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        onPressed: () {
          controller.editBooking(
            index,
            nameEditController.text,
            double.tryParse(priceEditController.text) ?? currentPrice,
          );
        },
        child: const Text("Save", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class DashedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    var path = Path()
      ..addRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), const Radius.circular(5)));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}