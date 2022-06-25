import 'package:get/instance_manager.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/transaction/detail_transaction_controller.dart';
import 'package:tugas_akhir_stenly_rachmad/services/repository.dart';

class DetailTransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailTransactionController());
    Get.lazyPut(() => Repository());
  }
}
