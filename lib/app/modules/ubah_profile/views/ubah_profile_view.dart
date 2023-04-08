import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ubah_profile_controller.dart';

class UbahProfileView extends GetView<UbahProfileController> {
  UbahProfileView({Key? key}) : super(key: key);
  final Map<String, dynamic> pegawai = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.nipC.text = pegawai['nip'] ?? '';
    controller.nameC.text = pegawai['name'] ?? '';
    controller.emailC.text = pegawai['email'] ?? '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Profile'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            readOnly: true,
            controller: controller.nipC,
            autocorrect: false,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'NIP',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            readOnly: true,
            controller: controller.emailC,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            controller: controller.nameC,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: 'Nama',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Photo Profile',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<UbahProfileController>(
                builder: (c) {
                  if (c.image != null) {
                    return ClipOval(
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Image.file(
                          File(c.image!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    if (pegawai['image_profile'] != null) {
                      return Column(
                        children: [
                          ClipOval(
                            child: Container(
                              height: 100,
                              width: 100,
                              child: Image.network(
                                pegawai['image_profile'].toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextButton(
                            onPressed: () {
                              Get.defaultDialog(
                                title: 'Menghapus Gambar Profile',
                                content: Text(
                                  'Apakah Yakin Ingin Menghapus Gambar Profile ?',
                                  textAlign: TextAlign.center,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      controller.deleteProfile(pegawai['uid']);
                                      Get.back();
                                      Get.back();
                                      Get.snackbar('Berhasil',
                                          'Berhasil Menghapus Gambar Profile');
                                    },
                                    child: Text('Yes'),
                                  ),
                                ],
                              );
                            },
                            child: Text(
                              'Hapus Photo Profile',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Text('Tidak Ada');
                    }
                  }
                },
              ),
              TextButton(
                onPressed: () => controller.imagePicker(),
                child: Text('Pilih Gambar'),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () => controller.ubahProfile(pegawai['uid'].toString()),
            child: Text('Ubah'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 20),
            ),
          ),
        ],
      ),
    );
  }
}
