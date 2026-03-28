import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: const Color(0xFFEDBE53),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  children: [
                    const Icon(Icons.calendar_today_outlined, size: 80, color: Colors.white),
                    const SizedBox(height: 10),
                    const Text("Test App", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                    const Text("for events management", style: TextStyle(color: Colors.black87)),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.7,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Test App", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFFEDBE53))),
                    const Text("HI, SIGNIN!", style: TextStyle(fontSize: 16, color: Colors.grey)),
                    const SizedBox(height: 35),

                    TextField(
                      controller: controller.userNameController,
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.person_outline),
                        hintText: "User Name",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    const SizedBox(height: 20),

                    TextField(
                      controller: controller.passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.visibility_off_outlined),
                        hintText: "********",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text("Forgot Password?", style: TextStyle(color: Colors.grey, fontSize: 13)),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 140,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFC69C3D).withOpacity(0.4),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () => controller.login(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFC69C3D),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 0,
                            ),
                            child: const Text("LOGIN", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("New Member?", style: TextStyle(color: Colors.black54, fontSize: 14)),
                            GestureDetector(
                              onTap: () {},
                              child: const Text("SIGN UP",
                                  style: TextStyle(color: Color(0xFFC69C3D), fontWeight: FontWeight.bold, decoration: TextDecoration.underline)
                              ),
                            ),
                          ],
                        ),


                      ],
                    ),

                    const SizedBox(height: 40),

                     Center(
                       child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.arrow_forward, color: Colors.black, size: 18),
                              Text("Get Start Now", style: TextStyle(color: Colors.black, fontSize: 15)),
                            ],
                          ),
                     ),


                  ],
                ),
              ),

              Container(
                height: 50,
                color: const Color(0xFFEDBE53),
              )
            ],
          ),
        ),
      ),
    );
  }
}