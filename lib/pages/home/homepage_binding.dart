import 'package:get/instance_manager.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/detail/detail_controller.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/home/homepage_controller.dart';

class HomepageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomepageController());
    Get.lazyPut(() => DetailController());
  }
}
