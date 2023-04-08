import 'package:get/get.dart';

import '../controllers/profile_pegawai_controller.dart';

class ProfilePegawaiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilePegawaiController>(
      () => ProfilePegawaiController(),
    );
  }
}
