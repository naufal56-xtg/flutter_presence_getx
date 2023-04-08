import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ubah_password_controller.dart';

class UbahPasswordView extends GetView<UbahPasswordController> {
  const UbahPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Password'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Obx(
            () => TextField(
              controller: controller.oldPassC,
              autocorrect: false,
              obscureText: controller.isHidePass.isFalse ? true : false,
              decoration: InputDecoration(
                labelText: 'Current Password',
                suffixIcon: IconButton(
                  onPressed: () => controller.isHidePass.toggle(),
                  icon: controller.isHidePass.isFalse
                      ? Icon(Icons.remove_red_eye)
                      : Icon(Icons.remove_red_eye_outlined),
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Obx(
            () => TextField(
              controller: controller.newPassC,
              autocorrect: false,
              obscureText: controller.isHidePass.isFalse ? true : false,
              decoration: InputDecoration(
                labelText: 'New Password',
                suffixIcon: IconButton(
                  onPressed: () => controller.isHidePass.toggle(),
                  icon: controller.isHidePass.isFalse
                      ? Icon(Icons.remove_red_eye)
                      : Icon(Icons.remove_red_eye_outlined),
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Obx(
            () => TextField(
              controller: controller.conPassC,
              autocorrect: false,
              obscureText: controller.isHidePass.isFalse ? true : false,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                suffixIcon: IconButton(
                  onPressed: () => controller.isHidePass.toggle(),
                  icon: controller.isHidePass.isFalse
                      ? Icon(Icons.remove_red_eye)
                      : Icon(Icons.remove_red_eye_outlined),
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () => controller.ubahPassword(),
            child: Text('Ubah Password'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 20),
            ),
          ),
        ],
      ),
    );
  }
}
