import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugas_akhir_stenly_rachmad/app_routes.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/master_controller.dart';

class SplashController extends GetxController {
  GetStorage box = GetStorage();

  void checkAuth() => Timer(Duration(seconds: 6), () {
        if (box.hasData('auth')) {
          Get.put(MasterController());
          Get.offAllNamed(AppRoutes.masterRoute);
        } else {
          Get.offAllNamed(AppRoutes.loginRoute);
        }
      });

  @override
  void onInit() {
    super.onInit();
    checkAuth();
  }
}
