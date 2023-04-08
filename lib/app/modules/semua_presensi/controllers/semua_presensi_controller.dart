import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class SemuaPresensiController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DateTime? start;
  DateTime end = DateTime.now();

  Future<QuerySnapshot<Map<String, dynamic>>> getPresence() async {
    initializeDateFormatting('id_ID', null);
    String uid = auth.currentUser!.uid;

    // String startDate =
    //     DateFormat.yMd('id_ID').format(start!).replaceAll('/', '-');
    // String endDate = DateFormat.yMd('id_ID').format(end).replaceAll('/', '-');

    if (start == null) {
      return await firestore
          .collection('pegawai')
          .doc(uid)
          .collection('absensi')
          .where('tanggal', isLessThan: end.toIso8601String())
          .orderBy('tanggal', descending: true)
          .get();
    } else {
      return await firestore
          .collection('pegawai')
          .doc(uid)
          .collection('absensi')
          .where('tanggal', isGreaterThan: start!.toIso8601String())
          .where('tanggal',
              isLessThan: end
                  .add(
                    Duration(days: 1),
                  )
                  .toIso8601String())
          .orderBy('tanggal', descending: true)
          .get();
    }
  }

  void pickerDate(DateTime pickStart, DateTime pickEnd) {
    start = pickStart;
    end = pickEnd;
    update();
  }
}
