import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_pegawai_controller.dart';

class AddPegawaiView extends GetView<AddPegawaiController> {
  const AddPegawaiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Pegawai'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.nipC,
            autocorrect: false,
            keyboardType: TextInputType.number,
            maxLength: 10,
            decoration: InputDecoration(
              labelText: 'NIP',
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
          TextField(
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
          Container(
            child: DropdownButtonFormField(
              hint: Text('Job/Pekerjaan'),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              isExpanded: true,
              items: [
                DropdownMenuItem<String>(
                  child: Text('Developer'),
                  value: 'Developer',
                ),
                DropdownMenuItem<String>(
                  child: Text('Staff'),
                  value: 'Staff',
                ),
                DropdownMenuItem<String>(
                  child: Text('IT Support'),
                  value: 'IT Support',
                ),
                DropdownMenuItem<String>(
                  child: Text('HRD / GA'),
                  value: 'HRD/GA',
                ),
                DropdownMenuItem<String>(
                  child: Text('Akuntansi'),
                  value: 'Akuntansi',
                ),
              ],
              onChanged: (value) {
                controller.jobC = value;
              },
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () => controller.addPegawai(),
            child: Text('Tambah Pegawai'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 20),
            ),
          ),
        ],
      ),
    );
  }
}
