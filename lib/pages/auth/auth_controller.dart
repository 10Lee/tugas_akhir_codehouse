import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugas_akhir_stenly_rachmad/app_routes.dart';
import 'package:tugas_akhir_stenly_rachmad/config/logger.dart';
import 'package:tugas_akhir_stenly_rachmad/services/repository.dart';

class AuthController extends GetxController {
  RxBool isObsecure = true.obs;
  RxBool isLoading = false.obs;

  GetStorage box = GetStorage();

  void toggleObsecure() {
    isObsecure.value ? isObsecure.value = false : isObsecure.value = true;
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Repository repo = Get.find<Repository>();

  void submitAccount({bool isLogin = false}) {
    try {
      isLoading.value = true;
      if (!isLogin) {
        repo
            .registerUser(
          email: emailController.text,
          name: usernameController.text,
          password: passwordController.text,
        )
            .then((value) {
          if (value.success!) {
            logger.i('RESPONSE DATA : ' + value.data.toString());
            box.write('auth', {
              'name': value.data!.name,
              'email': value.data!.email,
              'token': value.data!.token,
            }).then((value) => Get.offAllNamed(AppRoutes.splashRoute));
            isLoading.value = false;
          } else {
            logger.e('RESPONSE FAILED');
          }
        });
      } else {
        repo
            .loginUser(
          email: emailController.text,
          password: passwordController.text,
        )
            .then((value) {
          print("VALUE LOGIN : ${value.data!.email}");
          if (value.success!) {
            logger.i('RESPONSE DATA : ' + value.data.toString());
            box.write('auth', {
              'email': value.data!.email,
              'name': value.data!.name,
              'token': value.data!.token,
            }).then((value) => Get.offAllNamed(AppRoutes.splashRoute));
            isLoading.value = false;
          } else {
            Get.snackbar(
              'Error',
              'Kombinasi Email & Password anda tidak ada yang cocok',
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        });
      }
    } catch (e) {
      logger.e('FAILLED CALLING REPOSITORY : ', e.toString());
    }
  }
}
