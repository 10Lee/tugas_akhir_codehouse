import 'package:get/instance_manager.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/auth/auth_controller.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/splash/splash_controller.dart';
import 'package:tugas_akhir_stenly_rachmad/services/repository.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => Repository());
    Get.lazyPut(() => SplashController());
  }
}
