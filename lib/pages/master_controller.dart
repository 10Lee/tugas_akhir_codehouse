import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugas_akhir_stenly_rachmad/app_routes.dart';
import 'package:tugas_akhir_stenly_rachmad/config/logger.dart';

import 'home/homepage.dart';
import 'stats/stats.dart';

class MasterController extends GetxController {
  RxInt currentIndex = 0.obs;
  GetStorage box = GetStorage();

  get userName => box.read('auth')['token'];

  List<Widget> pages = [const HomePage(), StatsPage()];

  void logoutAccount() {
    box.remove('auth');
    logger.i("Loggout Success");
    Get.offAllNamed(AppRoutes.splashRoute);
  }
}
