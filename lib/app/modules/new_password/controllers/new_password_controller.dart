import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_presensi_getx/app/routes/app_pages.dart';
import 'package:get/get.dart';

class NewPasswordController extends GetxController {
  TextEditingController newPassC = TextEditingController();
  var isHidePass = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  void newPassword() async {
    if (newPassC.text.isNotEmpty) {
      if (newPassC.text != 'pegawai123') {
        try {
          String email = auth.currentUser!.email!;
          await auth.currentUser!.updatePassword(newPassC.text);
          await auth.signOut();
          await auth.signInWithEmailAndPassword(
              email: email, password: newPassC.text);
          Get.snackbar('Berhasil', 'Password Berhasil Diubah');
          Get.offAllNamed(Routes.HOME);
        } on FirebaseAuthException catch (e) {
          print(e.code.toString());
          if (e.code == 'weak-password') {
            Get.snackbar(
                'Terjadi Kesalahan', 'Password Harus Lebih Dari 6 Character');
          } else if (e.code == 'wrong-password') {
            Get.snackbar('Terjadi Kesalahan', 'Password Salah');
          }
        } catch (err) {
          Get.snackbar(
              'Terjadi Kesalahan', 'Tidak Dapat Mengubah New Password');
        }
      } else {
        Get.defaultDialog(
          title: 'Terjadi Kesalahan',
          middleText: 'Password Tidak Boleh Sama Kembali',
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text('OK'),
            ),
          ],
        );
      }
    } else {
      Get.defaultDialog(
        title: 'Terjadi Kesalahan',
        middleText: 'New Password Tidak Boleh Kosong',
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('OK'),
          ),
        ],
      );
    }
  }
}
