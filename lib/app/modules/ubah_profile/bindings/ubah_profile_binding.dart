import 'package:get/get.dart';

import '../controllers/ubah_profile_controller.dart';

class UbahProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UbahProfileController>(
      () => UbahProfileController(),
    );
  }
}
