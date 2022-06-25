import 'package:get/instance_manager.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/master_controller.dart';

class MasterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MasterController());
  }
}
