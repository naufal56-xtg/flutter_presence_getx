import 'package:get/get.dart';

import '../modules/add_pegawai/bindings/add_pegawai_binding.dart';
import '../modules/add_pegawai/views/add_pegawai_view.dart';
import '../modules/forget_password/bindings/forget_password_binding.dart';
import '../modules/forget_password/views/forget_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/lihat_presensi/bindings/lihat_presensi_binding.dart';
import '../modules/lihat_presensi/views/lihat_presensi_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/new_password/bindings/new_password_binding.dart';
import '../modules/new_password/views/new_password_view.dart';
import '../modules/profile_pegawai/bindings/profile_pegawai_binding.dart';
import '../modules/profile_pegawai/views/profile_pegawai_view.dart';
import '../modules/semua_presensi/bindings/semua_presensi_binding.dart';
import '../modules/semua_presensi/views/semua_presensi_view.dart';
import '../modules/ubah_password/bindings/ubah_password_binding.dart';
import '../modules/ubah_password/views/ubah_password_view.dart';
import '../modules/ubah_profile/bindings/ubah_profile_binding.dart';
import '../modules/ubah_profile/views/ubah_profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ADD_PEGAWAI,
      page: () => const AddPegawaiView(),
      binding: AddPegawaiBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PASSWORD,
      page: () => const NewPasswordView(),
      binding: NewPasswordBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD,
      page: () => const ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PEGAWAI,
      page: () => const ProfilePegawaiView(),
      binding: ProfilePegawaiBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.UBAH_PROFILE,
      page: () => UbahProfileView(),
      binding: UbahProfileBinding(),
    ),
    GetPage(
      name: _Paths.UBAH_PASSWORD,
      page: () => const UbahPasswordView(),
      binding: UbahPasswordBinding(),
    ),
    GetPage(
      name: _Paths.LIHAT_PRESENSI,
      page: () => const LihatPresensiView(),
      binding: LihatPresensiBinding(),
    ),
    GetPage(
      name: _Paths.SEMUA_PRESENSI,
      page: () => const SemuaPresensiView(),
      binding: SemuaPresensiBinding(),
    ),
  ];
}
