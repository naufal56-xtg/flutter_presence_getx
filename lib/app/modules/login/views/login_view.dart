import 'package:flutter/material.dart';
import 'package:flutter_presensi_getx/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Pegawai'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            autocorrect: false,
            controller: controller.emailC,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Obx(
            () => TextField(
              autocorrect: false,
              controller: controller.passC,
              obscureText: controller.isHideButton.isFalse ? true : false,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () => controller.isHideButton.toggle(),
                  icon: controller.isHideButton.isFalse
                      ? Icon(Icons.remove_red_eye)
                      : Icon(Icons.remove_red_eye_outlined),
                ),
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Obx(
            () => ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  await controller.login();
                }
              },
              child:
                  Text(controller.isLoading.isFalse ? 'Login' : 'Loading...'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20),
              ),
            ),
          ),
          SizedBox(
            height: 7,
          ),
          TextButton(
            onPressed: () => Get.toNamed(Routes.FORGET_PASSWORD),
            child: Text('Lupa Password ?'),
          ),
        ],
      ),
    );
  }
}
