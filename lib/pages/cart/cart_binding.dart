import 'package:get/instance_manager.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/cart/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartController());
  }
}
