import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tugas_akhir_stenly_rachmad/models/post_api/add_airsoft_model.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/home/homepage_controller.dart';
import 'package:tugas_akhir_stenly_rachmad/services/repository.dart';

class AddController extends GetxController {
  TextEditingController nameInputController = TextEditingController();
  TextEditingController descriptionInputController = TextEditingController();
  TextEditingController priceInputController = TextEditingController();

  RxBool isLoading = false.obs;

  Repository repo = Get.find<Repository>();
  HomepageController homepageController = Get.find<HomepageController>();

  Rx<File> fileImagePicker = Rx(File(""));
  final ImagePicker _imagePicker = ImagePicker();

  void getImage() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    fileImagePicker.value = File(image!.path);
  }

  void postNewAirsoft({
    required String name,
    required String price,
    required String description,
  }) {
    isLoading.value = true;
    int intPrice = int.parse(price);

    repo
        .postData(
      name: name,
      price: intPrice,
      description: description,
      file: fileImagePicker.value,
    )
        .then((PostModel result) {
      isLoading.value = true;
      print(result.message);
      if (result.success == true) {
        print('POST SUCCESS');
        homepageController.listOfAirsoft.add(result.data);

        isLoading.value = false;
        Get.offAllNamed('/');
      }
    }).onError((error, stackTrace) {
      print('ERROR : $error');
      print('STACKTRACE : $stackTrace');
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameInputController.dispose();
    descriptionInputController.dispose();
    priceInputController.dispose();
  }
}
