import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_presensi_getx/app/routes/app_pages.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late TextEditingController emailC;
  late TextEditingController passC;
  var isHideButton = false.obs;
  var isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    emailC = TextEditingController();
    passC = TextEditingController();
    super.onInit();
  }

  Future<void> login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: emailC.text, password: passC.text);

        print(userCredential);

        if (userCredential.user != null) {
          isLoading.value = false;
          if (passC.text == 'pegawai123') {
            Get.offAllNamed(Routes.NEW_PASSWORD);
          } else {
            Get.snackbar('Berhasil', 'Kamu Berhasil Login');
            Get.offAllNamed(Routes.HOME);
          }
          // if (userCredential.user!.emailVerified == true) {
          //   isLoading.value = false;
          //   if (passC.text == 'admin123') {
          //     Get.offAllNamed(Routes.NEW_PASSWORD);
          //   } else {
          //     Get.snackbar('Berhasil', 'Kamu Berhasil Login');
          //     Get.offAllNamed(Routes.HOME);
          //   }
          // } else {
          //   Get.defaultDialog(
          //     title: 'Verifikasi Email',
          //     middleText: 'Silahkan Verifikasi Email Terlebih Dahulu',
          //     actions: [
          //       TextButton(
          //         onPressed: () {
          //           isLoading.value = false;
          //           Get.back();
          //         },
          //         child: Text('Cancel'),
          //       ),
          //       ElevatedButton(
          //         onPressed: () async {
          //           try {
          //             await userCredential.user!.sendEmailVerification();
          //             Get.back();
          //             Get.snackbar('Berhasil',
          //                 'Silahkan Cek Email Untuk Verifikasi Akun');
          //             isLoading.value = false;
          //           } catch (e) {
          //             isLoading.value = false;
          //             Get.snackbar('Terjadi Kesalahan',
          //                 'Tidak Dapat Mengirim Email Verifikasi');
          //           }
          //         },
          //         child: Text('Kirim Ulang'),
          //       ),
          //     ],
          //   );
          // }
        }
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        print(e.code.toString());
        if (e.code == 'weak-password') {
          Get.snackbar(
              'Terjadi Kesalahan', 'Password Harus Lebih Dari 6 Character');
        } else if (e.code == 'wrong-password') {
          Get.snackbar('Terjadi Kesalahan', 'Password Salah');
        } else if (e.code == 'user-not-found') {
          Get.snackbar(
              'Terjadi Kesalahan', 'Email / Akun Tidak Ditemukan (Terdaftar)');
        }
      } catch (err) {
        isLoading.value = false;
        Get.snackbar(
            'Terjadi Kesalahan', 'Email / Password Salah Tidak Bisa Login');
      }
    } else {
      Get.snackbar('Terjadi Kesalahan', 'Email / Password Tidak Boleh Kosong');
    }
  }

  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();
    super.onClose();
  }
}
