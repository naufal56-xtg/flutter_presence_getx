import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';

class UbahProfileController extends GetxController {
  TextEditingController nipC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  fs.FirebaseStorage storage = fs.FirebaseStorage.instance;

  ImagePicker _imagePicker = ImagePicker();
  XFile? image;

  Future<void> ubahProfile(String uid) async {
    print(uid);
    if (nameC.text.isNotEmpty) {
      try {
        Map<String, dynamic> data = {
          "name": nameC.text,
        };
        if (image != null) {
          File file = File(image!.path);
          String ext = image!.name.split('.').last;

          await storage.ref('$uid/image_profile.$ext').putFile(file);
          String url =
              await storage.ref('$uid/image_profile.$ext').getDownloadURL();
          data.addAll({
            'image_profile': url,
          });
          // Get.back();
          // Get.snackbar('Berhasil', 'Ubah Profile Berhasil');
        }
        await firestore.collection('pegawai').doc(uid).update(data);
        Get.back();
        Get.snackbar('Berhasil', 'Ubah Profile Berhasil');
      } catch (e) {
        Get.snackbar(
            'Terjadi Kesalahan', 'Ubah Profile Gagal Silahkan Coba Lagi !');
      }
    } else {
      Get.snackbar('Terjadi Kesalahan', 'Data Tidak Boleh Kosong');
    }
  }

  void imagePicker() async {
    image = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      print(image!.name);
      print(image!.path);
    } else {
      print(image);
    }

    update();
  }

  Future<void> deleteProfile(String uid) async {
    try {
      await firestore.collection('pegawai').doc(uid).update({
        'image_profile': FieldValue.delete(),
      });
    } catch (e) {
      Get.snackbar('Terjadi Kesalahan',
          'Hapus Gambar Profile Gagal Silahkan Coba Lagi !');
    } finally {
      update();
    }
  }
}
