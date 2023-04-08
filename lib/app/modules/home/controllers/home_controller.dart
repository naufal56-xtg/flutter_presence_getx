import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_presensi_getx/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void logout() async {
    await auth.signOut();
    Get.snackbar('Berhasil', 'Anda Berhasil Logout');
    Get.offAllNamed(Routes.LOGIN);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore.collection('pegawai').doc(uid).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamLastPresence() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore
        .collection('pegawai')
        .doc(uid)
        .collection('absensi')
        .orderBy('tanggal', descending: true)
        .limitToLast(7)
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamTodayPresence() async* {
    String uid = auth.currentUser!.uid;

    String todayId =
        DateFormat.yMd('id_ID').format(DateTime.now()).replaceAll('/', '-');

    yield* firestore
        .collection('pegawai')
        .doc(uid)
        .collection('absensi')
        .doc(todayId)
        .snapshots();
  }
}
