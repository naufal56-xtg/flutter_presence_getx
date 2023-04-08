import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_presensi_getx/app/routes/app_pages.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class PageIndexController extends GetxController {
  var pageIndex = 0.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void changePage(int i) async {
    switch (i) {
      case 1:
        print('absen');
        Map<String, dynamic> data = await determinePosition();

        if (data['error'] == false) {
          Position position = data['position'];
          await updateLocation(position);
          List<Placemark> placemarks = await placemarkFromCoordinates(
              double.parse(position.latitude.toString()),
              double.parse(position.longitude.toString()),
              localeIdentifier: 'id_ID');

          // print(placemarks[0]);
          final String lokasi =
              '${placemarks[0].street},  ${placemarks[0].subAdministrativeArea} (${placemarks[0].postalCode})';
          await presence(position, lokasi);
        } else {
          Get.snackbar(
              'Terjadi Kesalahan', '${data['msg'].toString().capitalize}');
        }
        break;
      case 2:
        pageIndex.value = i;
        Get.offAllNamed(Routes.PROFILE_PEGAWAI);
        break;
      default:
        pageIndex.value = i;
        Get.offAllNamed(Routes.HOME);
    }
  }

  Future<void> presence(Position position, String lokasi) async {
    initializeDateFormatting('id_ID', null);
    String uid = await auth.currentUser!.uid;

    CollectionReference<Map<String, dynamic>> absensi =
        await firestore.collection('pegawai').doc(uid).collection('absensi');
    QuerySnapshot<Map<String, dynamic>> snapAbsen = await absensi.get();

    DateTime now = DateTime.now();

    String ymdId = DateFormat.yMd('id_ID').format(now).replaceAll('/', '-');

    if (snapAbsen.docs.length == 0) {
      await Get.defaultDialog(
        title: 'Absen Masuk',
        middleText: 'Apakah Kamu Yakin Ingin Melakukan Absen Masuk ?',
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              String timeout = DateFormat.Hm('id_ID').format(DateTime.now());
              if (double.parse(timeout.toString()) >= 08.00) {
                await absensi.doc(ymdId).set({
                  'tanggal': now.toIso8601String(),
                  'masuk': {
                    'tanggal': DateFormat.yMd('id_ID').format(now),
                    'waktu': DateFormat.Hm('id_ID').format(now),
                    'latitude': position.latitude,
                    'longitude': position.longitude,
                    'alamat': lokasi,
                  }
                });
                Get.back();
                Get.snackbar('Berhasil', 'Anda Berhasil Absen Masuk');
              } else {
                Get.back();
                Get.snackbar(
                  'Warning',
                  'Anda Belum Bisa Absen Masuk, Silhkan Tunggu Sampai Pukul (08.00)',
                );
              }
            },
            child: Text('Absen'),
          ),
        ],
      );
    } else {
      DocumentSnapshot<Map<String, dynamic>> checkAbsen =
          await absensi.doc(ymdId).get();
      if (checkAbsen.exists == true) {
        Map<String, dynamic>? dataAbsenToday = checkAbsen.data();
        if (dataAbsenToday?['keluar'] != null) {
          Get.snackbar('Warning', 'Anda Sudah Melakukan Absen Masuk & Keluar');
        } else {
          await Get.defaultDialog(
            title: 'Absen Masuk',
            middleText: 'Apakah Kamu Yakin Ingin Melakukan Absen Keluar ?',
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  String timeout =
                      DateFormat.Hm('id_ID').format(DateTime.now());
                  if (double.parse(timeout.toString()) < 16.00) {
                    Get.back();
                    Get.snackbar(
                      'Warning',
                      'Anda Belum Bisa Absen Keluar, Silhkan Tunggu Sampai Pukul (16.00)',
                    );
                  } else {
                    await absensi.doc(ymdId).update({
                      'keluar': {
                        'tanggal': DateFormat.yMd('id_ID').format(now),
                        'waktu': DateFormat.Hm('id_ID').format(now),
                        'latitude': position.latitude,
                        'longitude': position.longitude,
                        'alamat': lokasi,
                      }
                    });
                    Get.back();
                    Get.snackbar('Berhasil', 'Anda Berhasil Absen Keluar');
                  }
                },
                child: Text('Absen'),
              ),
            ],
          );
        }
      } else {
        await Get.defaultDialog(
          title: 'Absen Masuk',
          middleText: 'Apakah Kamu Yakin Ingin Melakukan Absen Masuk ?',
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                String timeout = DateFormat.Hm('id_ID').format(DateTime.now());
                if (double.parse(timeout.toString()) >= 08.00) {
                  await absensi.doc(ymdId).set({
                    'tanggal': now.toIso8601String(),
                    'masuk': {
                      'tanggal': DateFormat.yMd('id_ID').format(now),
                      'waktu': DateFormat.Hm('id_ID').format(now),
                      'latitude': position.latitude,
                      'longitude': position.longitude,
                      'alamat': lokasi,
                    }
                  });
                  Get.back();
                  Get.snackbar('Berhasil', 'Anda Berhasil Absen Masuk');
                } else {
                  Get.back();
                  Get.snackbar(
                    'Warning',
                    'Anda Belum Bisa Absen Masuk, Silhkan Tunggu Sampai Pukul (08.00)',
                  );
                }
              },
              child: Text('Absen'),
            ),
          ],
        );
      }
    }
  }

  Future<void> updateLocation(Position position) async {
    String uid = await auth.currentUser!.uid;
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude,
        localeIdentifier: 'id_ID');
    await firestore.collection('pegawai').doc(uid).update({
      'position': {
        'latitude': '${position.latitude}',
        'longitude': '${position.longitude}',
      },
      'location': {
        'street': placemarks[0].street.toString(),
        'city': placemarks[0].subAdministrativeArea.toString(),
        'province': placemarks[0].administrativeArea.toString(),
        'district': placemarks[0].locality.toString(),
        'village': placemarks[0].subLocality.toString(),
        'zip_code': placemarks[0].postalCode.toString(),
      }
    });
  }

  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      // return Future.error('Location services are disabled.');
      return {
        'msg': 'Akses Untuk Izin Lokasi Dimatikan',
        'error': true,
      };
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        // return Future.error('Location permissions are denied');
        return {
          'msg': 'Akses Untuk Izin Lokasi Ditolak',
          'error': true,
        };
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
      return {
        'msg':
            'Akses Untuk Izin Lokasi Ditolak, Membutuhkan Izin Lokasi Untuk Mengaksesnya',
        'error': true,
      };
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return {
      'position': position,
      'msg': 'Lokasi Anda Saat Ini',
      'error': false,
    };
  }
}
