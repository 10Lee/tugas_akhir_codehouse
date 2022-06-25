import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugas_akhir_stenly_rachmad/config/logger.dart';
import 'package:tugas_akhir_stenly_rachmad/models/get_api/result_airsoft_model.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/home/homepage_controller.dart';
import 'package:tugas_akhir_stenly_rachmad/services/repository.dart';

class DetailController extends GetxController {
  GetStorage box = GetStorage();

  Rx<ResultsAirsoftModel> detailData = Rx(ResultsAirsoftModel(qty: 0));
  RxBool isLoading = false.obs;
  RxList<ResultsAirsoftModel> cart = <ResultsAirsoftModel>[].obs;

  Repository repo = Get.find<Repository>();
  HomepageController homepageController = Get.find<HomepageController>();

  void callDetailApi(int? id) {
    isLoading.value = true;
    try {
      repo.getAirsoftDetail(id!).then((value) {
        if (value.success!) {
          logger.i('RESULTS NAME : ', value.data!.toJson());
          detailData.value = value.data!;
          isLoading.value = false;
        }
      });
    } catch (error, stackTrace) {
      logger.e('registerHasError', error, stackTrace);
    }
  }

  void deleteAirsoft(int index) {
    isLoading.value = true;
    repo.deleteData(index).then((value) {
      homepageController.listOfAirsoft
          .removeWhere((element) => element.id == index);

      Get.snackbar(
        'Message',
        value.message.toString(),
      );

      isLoading.value = false;
    }).onError((error, stackTrace) {
      logger.e("ERROR : $error");
      logger.e("STACKTRACE : $stackTrace");
    });
  }

  /// CART SECTION
  void addItemToCart(ResultsAirsoftModel airsoft) {
    airsoft.qty = 1;
    cart.add(airsoft);

    List<Map<String, dynamic>> items_cart =
        cart.map((ResultsAirsoftModel e) => e.toJson()).toList();

    box.write('items_cart', items_cart);
  }

  void getLastSessionData() {
    if (box.hasData('items_cart')) {
      List<dynamic> sessionData = box.read('items_cart');
      if (sessionData is List) {
        List<ResultsAirsoftModel> dataInModel =
            sessionData.map((e) => ResultsAirsoftModel.fromJson(e)).toList();
        cart.clear();
        cart.addAll(dataInModel);
      }
      listerForUpdate();
    }
  }

  void listerForUpdate() {
    box.listenKey('items_cart', (value) {
      logger.i('Perubahan terjadi pada cart $value');
      if (value is List) {
        List<ResultsAirsoftModel> dataInModel =
            value.map((e) => ResultsAirsoftModel.fromJson(e)).toList();
        cart.clear();
        cart.addAll(dataInModel);
      }
    });
  }

  void removeRecordFromCart(int id) {
    cart.removeWhere((element) => element.id == id);
    List<Map<String, dynamic>> items_cart =
        cart.map((element) => element.toJson()).toList();

    box.write('items_cart', items_cart);
  }

  void increaseQtyOfItemInCart(ResultsAirsoftModel airsoft) {
    cart.removeWhere((element) => element.id == airsoft.id);
    airsoft.qty++;
    cart.add(airsoft);
    List<Map<String, dynamic>> items_cart =
        cart.map((element) => element.toJson()).toList();

    box.write('items_cart', items_cart);
  }

  void decreaseQtyOfItemInCart(ResultsAirsoftModel airsoft) {
    if (airsoft.qty == 1) {
      cart.removeWhere((element) => element.id == airsoft.id);
    } else {
      cart.removeWhere((element) => element.id == airsoft.id);
      airsoft.qty--;
      cart.add(airsoft);
    }

    List<Map<String, dynamic>> items_cart =
        cart.map((element) => element.toJson()).toList();

    box.write('items_cart', items_cart);
  }

  @override
  void onReady() {
    super.onReady();
    getLastSessionData();
  }
}
