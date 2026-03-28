import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/hall_controller.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HallController());
    Color primaryColor = const Color(0xFF413DA2);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        toolbarHeight: 120,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => Get.toNamed("/BookingScreen"),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Obx(() => Text(
                        controller.bookedCount.value.toString().padLeft(2, '0'),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )),
                    ),
                    const SizedBox(width: 8),
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Your Cart",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        Text("Items added",
                            style: TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(" Hi ${controller.welcomeName}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                  const Text("Welcome back, where you \n wanna do in occasion today",
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: controller.halls.length,
        itemBuilder: (context, index) {
          final hall = controller.halls[index];

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.asset(hall.image,
                      height: 160, width: double.infinity, fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // جعل النصوص تبدأ من اليسار
                          children: [
                            Text(hall.name,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            const SizedBox(height: 4),
                            Text(hall.location,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 11)),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("25.12.2025 , 08:30 AM",
                                    style: TextStyle(
                                        color: Colors.orange, fontSize: 10)),
                                // زر الحجز (المطلب 6)
                                SizedBox(
                                  height: 30,
                                  child: ElevatedButton(
                                    onPressed: () =>
                                        controller.toggleBooking(index),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: hall.isBooked
                                          ? Colors.red
                                          : Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(5)),
                                    ),
                                    child: Text(
                                        hall.isBooked
                                            ? "UNBOOK"
                                            : "BOOKING NOW",
                                        style: const TextStyle(
                                            fontSize: 10, color: Colors.white)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 15),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            Text("${hall.rating}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            const Icon(Icons.star,
                                color: Colors.white, size: 14),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      )),
    );
  }
}