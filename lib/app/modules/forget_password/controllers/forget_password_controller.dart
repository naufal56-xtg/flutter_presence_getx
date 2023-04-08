import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_presensi_getx/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void forgetPassword() async {
    if (emailC.text.isNotEmpty) {
      try {
        auth.sendPasswordResetEmail(email: emailC.text);
        Get.back();
        Get.snackbar('Berhasil', 'Email Lupa Password Berhasil Dikirim');
      } catch (e) {
        Get.snackbar(
            'Terjadi Kesalahan', 'Tidak Dapat Mengirim Email Reset Password');
      }
    } else {
      Get.snackbar('Terjadi Kesalahan', 'Email Tidak Boleh Kosong');
    }
  }
}
