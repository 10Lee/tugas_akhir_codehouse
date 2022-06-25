import 'package:get/instance_manager.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/stats/stats_controller.dart';
import 'package:tugas_akhir_stenly_rachmad/services/repository.dart';

class StatsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StatsController());
    Get.lazyPut(() => Repository());
  }
}
