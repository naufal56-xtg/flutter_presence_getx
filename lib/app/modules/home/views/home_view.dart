import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_presensi_getx/app/controllers/page_index_controller.dart';
import 'package:flutter_presensi_getx/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageIndexC = Get.find<PageIndexController>();
    initializeDateFormatting('id_ID', null);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Presence App'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Colors.black],
            ),
          ),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final pegawai = snapshot.data!.data();

          return ListView(
            padding: EdgeInsets.all(20),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        gradient: LinearGradient(
                          colors: [Colors.red, Colors.black],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            ClipOval(
                              child: Container(
                                width: 75,
                                height: 75,
                                color: Colors.grey[200],
                                child: Image.network(
                                  pegawai!['image_profile'] != null
                                      ? pegawai['image_profile']
                                      : 'https://ui-avatars.com/api/?name=${pegawai['name']}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Welcome,",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[300],
                                  ),
                                ),
                                Container(
                                  width: Get.width * 0.55,
                                  child: Text(
                                    pegawai['position'] != null
                                        ? '${pegawai['location']['street']}, ${pegawai['location']['city']} (${pegawai['location']['zip_code']})'
                                        : '',
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.grey[300],
                                    ),
                                    maxLines: 3,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: Get.width,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      gradient: LinearGradient(
                        colors: [Colors.red, Colors.black],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pegawai['job'] == null ? "Pegawai," : pegawai['job'],
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[300],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${pegawai['nip']}",
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[300],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${pegawai['name'].toString().toUpperCase()}",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: Get.width,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      gradient: LinearGradient(
                        colors: [Colors.red, Colors.black],
                      ),
                    ),
                    child:
                        StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                            stream: controller.streamTodayPresence(),
                            builder: (context, todaySnap) {
                              if (todaySnap.connectionState ==
                                  ConnectionState.waiting) {
                                return SizedBox();
                              }
                              final dataToday = todaySnap.data!.data();
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Masuk",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[300],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        dataToday?['masuk'] != null
                                            ? dataToday!['masuk']['waktu']
                                                .toString()
                                            : "-",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey[300],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 2,
                                    height: 40,
                                    color: Colors.grey[300],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Keluar",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[300],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        dataToday?['keluar'] != null
                                            ? dataToday!['keluar']['waktu']
                                                .toString()
                                            : "-",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey[300],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "7 Hari Lalu",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.SEMUA_PRESENSI);
                        },
                        child: Text(
                          'Lihat',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: controller.streamLastPresence(),
                    builder: (context, snapshot2) {
                      if (snapshot2.connectionState ==
                          ConnectionState.waiting) {
                        return SizedBox();
                      }
                      if (snapshot2.data!.docs.length == 0 ||
                          snapshot2.data == null) {
                        return Center(
                          child: Text('Data Histori Presensi Kosong'),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot2.data!.docs.length,
                        itemBuilder: (context, index) {
                          final data = snapshot2.data!.docs[index].data();
                          return InkWell(
                            onTap: () {
                              Get.toNamed(Routes.LIHAT_PRESENSI,
                                  arguments: data);
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                ],
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: ConvexAppBar(
        gradient: LinearGradient(
          colors: [Colors.red, Colors.black],
        ),
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(
            icon: Icon(
              Icons.fingerprint,
              color: Colors.red,
              size: 45,
            ),
            title: 'Absen',
          ),
          TabItem(icon: Icons.people, title: 'Profile'),
          // TabItem(icon: Icons.message, title: 'Message'),
          // TabItem(icon: Icons.people, title: 'Profile'),
        ],
        initialActiveIndex: pageIndexC.pageIndex.value,
        style: TabStyle.fixedCircle,
        onTap: (int i) => pageIndexC.changePage(i),
      ),
    );
  }
}
