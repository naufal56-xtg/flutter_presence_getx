import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_presensi_getx/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ProfilePegawaiController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamPegawai() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore.collection('pegawai').doc(uid).snapshots();
  }

  void logout() async {
    await auth.signOut();
    Get.snackbar('Berhasil', 'Anda Berhasil Logout');
    Get.offAllNamed(Routes.LOGIN);
  }
}
