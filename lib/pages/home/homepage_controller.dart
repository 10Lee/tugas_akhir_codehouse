import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_stenly_rachmad/config/logger.dart';
import 'package:tugas_akhir_stenly_rachmad/models/data/sample_airsoft_list.dart';
import 'package:tugas_akhir_stenly_rachmad/models/get_api/result_airsoft_model.dart';
import 'package:tugas_akhir_stenly_rachmad/services/repository.dart';

class HomepageController extends GetxController {
  RxList<ResultsAirsoftModel> listOfAirsoft = <ResultsAirsoftModel>[].obs;
  Repository repo = Get.find<Repository>();
  RxBool isLoading = false.obs;
  RxBool isNoMoreLoad = false.obs;

  int page = 1;

  Rx<Matrix4> matrix = Rx(Matrix4.identity());

  void callApi() {
    isLoading.value = true;
    try {
      repo.getAirsoftList(page).then((value) {
        if (value.success!) {
          logger.i('RESULTS LENGTH : ', value.data!.results!.length);
          if (value.data!.results!.isEmpty) {
            isNoMoreLoad.value = true;
          }
          // value.data!.results!.map((e) => listOfAirsoft.add(e)).toList();

          // final results = value.data!.results!;
          // listOfAirsoft.value = [...listOfAirsoft, ...results];

          listOfAirsoft.value.addAll(value.data!.results!);
          isLoading.value = false;
        }
      });
    } catch (error, stackTrace) {
      logger.e('registerHasError', error, stackTrace);
    }
  }

  @override
  void onReady() {
    super.onReady();
    callApi();
  }
}
