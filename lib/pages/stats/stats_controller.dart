import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugas_akhir_stenly_rachmad/config/logger.dart';
import 'package:tugas_akhir_stenly_rachmad/models/get_api/transaction_model.dart';
import 'package:tugas_akhir_stenly_rachmad/services/repository.dart';

class StatsController extends GetxController {
  GetStorage box = GetStorage();
  RxList<Results> transactionList = <Results>[].obs;
  RxInt totalTransaction = 0.obs;

  // Perhitungan pembulatan nilai totalSpending ke satuan jutaan
  RxInt totalSpending = 0.obs;
  // get totalSpendingProcessed =>
  //     (getPreviousTotalSpending() / 1000000) + (totalSpending.value / 1000000);
  // get totalSpendingProcessed {
  //   var spend = box.read('spending');
  //   return spend += spend / 1000000;
  // }

  RxDouble totalPoin = 0.0.obs;

  RxBool isLoading = false.obs;
  RxBool isNoMoreLoad = false.obs;
  Repository repo = Get.find<Repository>();

  int page = 1;

  void getAllTransactionData() {
    isLoading.value = true;
    List<int> listOfIds = [];

    try {
      repo.getAllTransactionData(page).then(
        (value) {
          if (value.success!) {
            if (value.data!.results!.isEmpty) {
              isNoMoreLoad.value = true;
            }

            totalTransaction.value = value.data!.total!;

            value.data!.results!.map((e) {
              // Fill transactionList with API data
              transactionList.add(e);

              // Get and save the list of ids in list variable
              listOfIds.add(e.id!);
            }).toList();

            isLoading.value = false;
          } else {
            logger.e("RESPONSE /TRANSACTION FAILED TO LOAD");
            print('RESPONSE /TRANSACTION FAILED TO LOAD');
          }

          getTotalSpendingFromApi(listOfIds);
        },
      );
    } catch (e, stackTrace) {
      logger.e('GetAllTransactionDataHasError', e, stackTrace);
      print(e.toString());
      print(stackTrace.toString());
    }
  }

  void getTotalSpendingFromApi(List<int> listOfId) {
    List<int> priceTimesQty = [];

    for (int id in listOfId) {
      repo.getDetailTransactionData(id).then((value) {
        value.data!.detail!.map((e) {
          // save calculation result qty * price in variable
          priceTimesQty.add(e.qty! * e.price!);
        }).toList();
      });
    }

    if (priceTimesQty.isEmpty) return null;

    logger.e("PRICE TIMES QTY : $priceTimesQty");
    int val = priceTimesQty.reduce((a, b) => (a + b));
    logger.e("VAL : $val");
    final spending = val / 1000000;
    logger.e("SPENDING : $spending");

    // box.write('spending', spending);
  }

  // void getTotalSpendingValue() {
  //   if (box.hasData('spending')) {
  //     box.listenKey('spending', (value) {
  //       totalSpending.value = box.read('spending');
  //       logger.e('SPENDING VALUE : ${totalSpending.value}');
  //     });
  //   }
  // }

  // void calcPoin() {
  //   totalPoin.value = totalSpendingProcessed + (totalTransaction.value / 2);
  // }

  void clearBoxSpending() {
    box.remove('spending');
    if (box.hasData('spending')) {
      box.read('spending');
    } else {
      logger.e('BOX KOSONG');
    }
  }

  @override
  void onInit() {
    super.onInit();
    getAllTransactionData();
  }
}
