import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugas_akhir_stenly_rachmad/app_routes.dart';
import 'package:tugas_akhir_stenly_rachmad/config/logger.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/stats/stats%20copy.dart';

import 'home/homepage.dart';
import 'stats/stats.dart';

class MasterController extends GetxController {
  RxInt currentIndex = 0.obs;
  GetStorage box = GetStorage();

  get userName => box.read('auth')['name'];

  List<Widget> pages = [const HomePage(), StatsCopy()];

  void logoutAccount() {
    box.remove('auth');
    logger.i("Loggout Success");
    Get.offAllNamed(AppRoutes.splashRoute);
  }
}
