import 'package:get/get.dart';

import '../controllers/lihat_presensi_controller.dart';

class LihatPresensiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LihatPresensiController>(
      () => LihatPresensiController(),
    );
  }
}
