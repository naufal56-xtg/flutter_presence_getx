import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../controllers/lihat_presensi_controller.dart';

class LihatPresensiView extends GetView<LihatPresensiController> {
  const LihatPresensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = Get.arguments;
    initializeDateFormatting('id_ID', null);
    return Scaffold(
      appBar: AppBar(
        title: const Text('LIHAT DETAIL PRESENSI'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Colors.black],
            ),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: LinearGradient(
                colors: [Colors.red, Colors.black],
              ),
            ),
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    '${DateFormat.yMMMMd('id_ID').format(
                      DateTime.parse(data['tanggal'].toString()),
                    )}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Masuk",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[300],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Jam : ${data['masuk']['waktu'].toString()}',
                  style: TextStyle(
                    color: Colors.grey[300],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Posisi : ${data['masuk']['latitude'].toString()}, ${data['masuk']['longitude'].toString()}",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[300],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Lokasi : ${data['masuk']['alamat'].toString()}",
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 14.0,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.grey[300],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  thickness: 3,
                  color: Colors.grey[300],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Keluar",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[300],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  data['keluar'] != null
                      ? 'Jam : ${data['keluar']['waktu']}'
                      : 'Jam : -',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[300],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  data['keluar'] != null
                      ? 'Posisi : ${data['keluar']['latitude'].toString()}, ${data['keluar']['longitude'].toString()}'
                      : 'Posisi : -',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[300],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  data['keluar'] != null
                      ? 'Lokasi : ${data['keluar']['alamat'].toString()}'
                      : 'Lokasi : -',
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 14.0,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
