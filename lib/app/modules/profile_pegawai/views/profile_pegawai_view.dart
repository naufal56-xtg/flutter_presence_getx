import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_presensi_getx/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../../../controllers/page_index_controller.dart';
import '../controllers/profile_pegawai_controller.dart';

class ProfilePegawaiView extends GetView<ProfilePegawaiController> {
  const ProfilePegawaiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageIndexC = Get.find<PageIndexController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
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
        stream: controller.streamPegawai(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox();
          }
          if (snapshot.hasData) {
            Map<String, dynamic> pegawai = snapshot.data!.data()!;
            return ListView(
              padding: EdgeInsets.all(20),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Container(
                        width: 100,
                        height: 100,
                        child: Image.network(
                          pegawai['image_profile'] != null
                              ? pegawai['image_profile']
                              : 'https://ui-avatars.com/api/?name=${pegawai['name']}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  pegawai['nip'].toString(),
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  pegawai['name'].toString().toUpperCase(),
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  pegawai['email'].toString(),
                  style: TextStyle(
                    fontSize: 16.0,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 25,
                ),
                CardPofileWidget(
                  pegawai: pegawai,
                  title: 'Ubah Profile',
                  icon: Icons.person,
                  onTap: () =>
                      Get.toNamed(Routes.UBAH_PROFILE, arguments: pegawai),
                ),
                CardPofileWidget(
                  pegawai: pegawai,
                  title: 'Ubah Password',
                  icon: Icons.vpn_key,
                  onTap: () => Get.toNamed(Routes.UBAH_PASSWORD),
                ),
                if (pegawai['role'] == 'admin')
                  CardPofileWidget(
                    pegawai: pegawai,
                    title: 'Tambah Pegawai',
                    icon: Icons.person_add,
                    onTap: () => Get.toNamed(Routes.ADD_PEGAWAI),
                  ),
                CardPofileWidget(
                  pegawai: pegawai,
                  title: 'Logout',
                  icon: Icons.logout,
                  onTap: () => controller.logout(),
                ),
              ],
            );
          } else {
            return SizedBox();
          }
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

class CardPofileWidget extends StatelessWidget {
  const CardPofileWidget({
    Key? key,
    required this.pegawai,
    required this.title,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  final Map<String, dynamic> pegawai;
  final String title;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: LinearGradient(
            colors: [Colors.red, Colors.black],
          ),
        ),
        child: ListTile(
          onTap: onTap,
          leading: Icon(
            icon,
            color: Colors.grey[300],
          ),
          title: Text(
            '$title',
            style: TextStyle(color: Colors.grey[300]),
          ),
        ),
      ),
    );
  }
}
