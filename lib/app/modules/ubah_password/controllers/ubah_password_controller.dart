import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UbahPasswordController extends GetxController {
  TextEditingController newPassC = TextEditingController();
  TextEditingController oldPassC = TextEditingController();
  TextEditingController conPassC = TextEditingController();
  var isHidePass = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> ubahPassword() async {
    if (oldPassC.text.isNotEmpty &&
        newPassC.text.isNotEmpty &&
        conPassC.text.isNotEmpty) {
      if (newPassC.text == conPassC.text) {
        try {
          String email = auth.currentUser!.email!;

          await auth.signInWithEmailAndPassword(
              email: email, password: oldPassC.text);

          await auth.currentUser!.updatePassword(newPassC.text);

          await auth.signOut();

          await auth.signInWithEmailAndPassword(
              email: email, password: newPassC.text);

          Get.back();
          Get.snackbar('Berhasil', 'Anda Berhasil Ubah Password');
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Get.snackbar(
                'Terjadi Kesalahan', 'Password Harus Lebih Dari 6 Character');
          } else if (e.code == 'wrong-password') {
            Get.snackbar('Terjadi Kesalahan',
                'Password Salah ! Silahkan Ulangin Lagi !');
          } else {
            Get.snackbar('Terjadi Kesalahan',
                '${e.code.toLowerCase()} | ${e.message.toString().toLowerCase()}');
          }
        } catch (e) {
          Get.snackbar('Terjadi Kesalahan',
              'Tidak Dapat Mengubah Password ! Silahkan Coba Lagi !');
        }
      } else {
        Get.snackbar('Terjadi Kesalahan', 'Password Tidak Cocok');
      }
    } else {
      Get.snackbar('Terjadi Kesalahan', 'Password Tidak Boleh Kosong');
    }
  }
}
