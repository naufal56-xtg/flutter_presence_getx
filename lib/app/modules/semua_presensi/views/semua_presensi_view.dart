// ignore_for_file: unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_presensi_getx/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../controllers/semua_presensi_controller.dart';

class SemuaPresensiView extends GetView<SemuaPresensiController> {
  const SemuaPresensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID', null);
    return Scaffold(
      appBar: AppBar(
        title: const Text('LIHAT SEMUA PRESENSI'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Colors.black],
            ),
          ),
        ),
      ),
      body: GetBuilder<SemuaPresensiController>(
        builder: (controller) =>
            FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: controller.getPresence(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox();
            }
            if (snapshot.data!.docs.length == 0 || snapshot.data == null) {
              return SizedBox(
                height: 150,
                child: Center(
                  child: Text('Data Histori Semua Presensi Kosong'),
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.all(20),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data = snapshot.data!.docs[index].data();
                return InkWell(
                  onTap: () {
                    Get.toNamed(Routes.LIHAT_PRESENSI, arguments: data);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 15),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: LinearGradient(
                        colors: [Colors.red, Colors.black],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Masuk",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[300],
                              ),
                            ),
                            Text(
                              "${DateFormat.yMMMMd('id_ID').format(DateTime.parse(data['tanggal']))}",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[300],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          '${data['masuk']['waktu']}',
                          style: TextStyle(
                            color: Colors.grey[300],
                          ),
                        ),
                        SizedBox(
                          height: 15,
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
                          height: 7,
                        ),
                        Text(
                          data['keluar'] != null
                              ? '${data['keluar']['waktu']}'
                              : '-',
                          style: TextStyle(
                            color: Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.format_list_bulleted_outlined),
        onPressed: () {
          Get.dialog(
            Dialog(
              child: Container(
                padding: EdgeInsets.all(15),
                height: 400,
                child: SfDateRangePicker(
                  view: DateRangePickerView.month,
                  monthViewSettings:
                      DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                  selectionMode: DateRangePickerSelectionMode.range,
                  showActionButtons: true,
                  onCancel: () => Get.back(),
                  onSubmit: (obj) {
                    if (obj != null) {
                      if ((obj as PickerDateRange).endDate != null) {
                        controller.pickerDate((obj).startDate!, (obj).endDate!);
                        Get.back();
                      } else {
                        Get.back();
                        Get.snackbar(
                          'Terjadi Kesalahan',
                          'Tanggal Akhir Tidak Boleh Kosong, Pilih Tanggal',
                        );
                      }
                    } else {
                      Get.back();
                      Get.snackbar(
                        'Terjadi Kesalahan',
                        'Tanggal/Hari Tidak Boleh Kosong ! Silahkan Pilih Tanggal',
                      );
                    }
                  },
                ),
              ),
            ),
          );
        },
        backgroundColor: Colors.red,
      ),
    );
  }
}
