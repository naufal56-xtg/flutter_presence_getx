import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPegawaiController extends GetxController {
  TextEditingController nipC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passAdminC = TextEditingController();
  String? jobC;

  var isHidePass = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> prosesAddPegawai() async {
    if (passAdminC.text.isNotEmpty) {
      try {
        String emailAdmin = auth.currentUser!.email!;

        UserCredential adminCredential = await auth.signInWithEmailAndPassword(
            email: emailAdmin, password: passAdminC.text);

        UserCredential pegawaiCredential =
            await auth.createUserWithEmailAndPassword(
                email: emailC.text, password: 'pegawai123');

        if (pegawaiCredential.user != null) {
          String uid = pegawaiCredential.user!.uid;

          await firestore.collection('pegawai').doc(uid).set({
            "nip": nipC.text,
            "name": nameC.text,
            "email": emailC.text,
            "uid": uid,
            "role": "pegawai",
            'job': jobC,
            "createdAt": DateTime.now().toIso8601String(),
          });

          await pegawaiCredential.user!.sendEmailVerification();

          await auth.signOut();
          UserCredential adminCredential =
              await auth.signInWithEmailAndPassword(
                  email: emailAdmin, password: passAdminC.text);

          Get.back();
          Get.back();
          print(adminCredential);
        }
        print(adminCredential);
        Get.snackbar('Berhasil', 'Berhasil Menambahkan Pegawai');
      } on FirebaseAuthException catch (e) {
        print(e.code.toString());
        if (e.code == 'email-already-in-use') {
          Get.snackbar('Terjadi Kesalahan',
              'Email Sudah Terdaftar Silahkan Coba Email Lain');
        } else if (e.code == 'weak-password') {
          Get.snackbar(
              'Terjadi Kesalahan', 'Password Harus Lebih Dari 6 Character');
        } else if (e.code == 'wrong-password') {
          Get.snackbar('Terjadi Kesalahan', 'Password Salah');
        } else {
          Get.snackbar('Terjadi Kesalahan', '${e.code} | ${e.message}');
        }
      } catch (err) {
        Get.snackbar('Terjadi Kesalahan', 'Tidak Dapat Menambah Pegawai');
      }
    } else {
      Get.snackbar(
          'Terjadi Kesalahan', 'Password Admin Wajib Di Isi Untuk Validasi');
    }
  }

  void addPegawai() async {
    if (nipC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        jobC != '') {
      Get.defaultDialog(
        title: 'Validasi Admin',
        content: Column(
          children: [
            Text(
              'Masukan Password Admin Untuk Validasi',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 7,
            ),
            TextField(
              controller: passAdminC,
              autocorrect: false,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await prosesAddPegawai();
            },
            child: Text('Confirm'),
          ),
        ],
      );
      // try {
      //   UserCredential adminCredential =
      //       await auth.createUserWithEmailAndPassword(
      //           email: emailC.text, password: 'admin123');

      //   if (adminCredential.user != null) {
      //     String uid = adminCredential.user!.uid;

      //     await firestore.collection('pegawai').doc(uid).set({
      //       "nip": nipC.text,
      //       "name": nameC.text,
      //       "email": emailC.text,
      //       "uid": uid,
      //       "createdAt": DateTime.now().toIso8601String(),
      //     });

      //     await adminCredential.user!.sendEmailVerification();
      //   }
      //   Get.snackbar('Berhasil', 'Berhasil Menambahkan Pegawai');
      // } on FirebaseAuthException catch (e) {
      //   print(e.code.toString());
      //   if (e.code == 'email-already-in-use') {
      //     Get.snackbar('Terjadi Kesalahan',
      //         'Email Sudah Terdaftar Silahkan Coba Email Lain');
      //   } else if (e.code == 'weak-password') {
      //     Get.snackbar(
      //         'Terjadi Kesalahan', 'Password Harus Lebih Dari 6 Character');
      //   } else if (e.code == 'wrong-password') {
      //     Get.snackbar('Terjadi Kesalahan', 'Password Salah');
      //   } else {
      //     Get.snackbar('Terjadi Kesalahan', '${e.code} | ${e.message}');
      //   }
      // } catch (err) {
      //   Get.snackbar('Terjadi Kesalahan', 'Tidak Dapat Menambah Pegawai');
      // }
    } else {
      Get.snackbar('Terjadi Kesalahan', 'Data Tidak Boleh Kosong');
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
