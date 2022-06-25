import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/auth/auth_controller.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/master_controller.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/splash/splash_controller.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MasterController());
    Get.lazyPut(() => SplashController());
  }
}
