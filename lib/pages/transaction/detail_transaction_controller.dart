import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tugas_akhir_stenly_rachmad/config/logger.dart';
import 'package:tugas_akhir_stenly_rachmad/models/get_api/detail_transaction_model.dart';
import 'package:tugas_akhir_stenly_rachmad/services/repository.dart';

class DetailTransactionController extends GetxController {
  RxList<Detail> detailTransData = <Detail>[].obs;
  RxInt detailTransId = 0.obs;
  RxString detailTransCode = ''.obs;
  RxString detailTransDate = ''.obs;
  RxBool isLoading = false.obs;

  Repository repo = Get.find<Repository>();

  void getDetailTransactionData() {
    isLoading.value = true;
    try {
      repo.getDetailTransactionData(Get.arguments['id']).then(
        (value) {
          if (value.success!) {
            detailTransId.value = value.data!.id!;
            detailTransCode.value = value.data!.transCode!;
            detailTransDate.value = value.data!.date!;
            detailTransData.value = value.data!.detail!;

            // Get total spending value
            // value.data!.detail!.forEach((element) {
            //   totalSpending = totalSpending + (element.price! * element.qty!);
            // });

            isLoading.value = false;
          }
        },
      );
    } catch (e, stackTrace) {
      logger.e(e.toString());
      logger.e(stackTrace.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    getDetailTransactionData();
  }
}
