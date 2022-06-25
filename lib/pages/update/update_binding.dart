import 'package:get/instance_manager.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/add/add_controller.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/update/update_controller.dart';

class UpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateController());
    Get.lazyPut(() => AddController());
  }
}
