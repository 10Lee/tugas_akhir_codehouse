import 'package:get/instance_manager.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/add/add_controller.dart';
import 'package:tugas_akhir_stenly_rachmad/services/repository.dart';

class AddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddController());
    Get.lazyPut(() => Repository());
  }
}
