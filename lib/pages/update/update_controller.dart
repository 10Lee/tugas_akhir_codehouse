import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tugas_akhir_stenly_rachmad/app_routes.dart';
import 'package:tugas_akhir_stenly_rachmad/config/logger.dart';
import 'package:tugas_akhir_stenly_rachmad/models/get_api/update_model.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/home/homepage_controller.dart';
import 'package:tugas_akhir_stenly_rachmad/services/repository.dart';

class UpdateController extends GetxController {
  HomepageController homeController = Get.find<HomepageController>();

  late TextEditingController nameInputController;
  late TextEditingController priceInputController;
  late TextEditingController descriptionInputController;

  Rx<File> fileImagePicker = Rx(File(""));
  final ImagePicker _imagePicker = ImagePicker();

  RxBool isLoading = false.obs;

  String uploadImageUrl = Get.arguments['file_input'];

  void getImage() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    fileImagePicker.value = File(image!.path);
  }

  Repository repo = Get.find<Repository>();

  void updateAirsoftData({
    required String name,
    required String price,
    required String description,
  }) {
    isLoading.value = true;
    int intPrice = int.parse(price);

    repo
        .updateData(
      id: Get.arguments['id_input'],
      name: name,
      price: intPrice,
      description: description,
      file: fileImagePicker.value,
    )
        .then((UpdateModel result) {
      if (result.success == true) {
        print('POST SUCCESS');
        homeController.callApi();
        isLoading.value = false;
        Get.offAllNamed(AppRoutes.masterRoute);
      }
    }).onError((error, stackTrace) {
      logger.e('ERROR : $error');
      logger.e('STACKTRACE : $stackTrace');
    });
  }

  @override
  void onInit() {
    nameInputController =
        TextEditingController(text: Get.arguments['name_input']);
    priceInputController =
        TextEditingController(text: Get.arguments['price_input']);
    descriptionInputController =
        TextEditingController(text: Get.arguments['desc_input']);

    super.onInit();
  }

  @override
  void dispose() {
    nameInputController.dispose();
    priceInputController.dispose();
    descriptionInputController.dispose();

    super.dispose();
  }
}
