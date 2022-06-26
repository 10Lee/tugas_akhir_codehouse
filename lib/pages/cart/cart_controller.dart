import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugas_akhir_stenly_rachmad/app_routes.dart';
import 'package:tugas_akhir_stenly_rachmad/config/logger.dart';
import 'package:tugas_akhir_stenly_rachmad/models/get_api/cart_model.dart';
import 'package:tugas_akhir_stenly_rachmad/models/get_api/result_airsoft_model.dart';
import 'package:tugas_akhir_stenly_rachmad/models/post_api/add_transaction_model.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/home/homepage_controller.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/stats/stats_controller.dart';
import 'package:tugas_akhir_stenly_rachmad/services/repository.dart';

class CartController extends GetxController {
  GetStorage box = GetStorage();
  Map<String, dynamic> userSession = GetStorage().read('auth');

  Rx<ResultsAirsoftModel> detailData = Rx(ResultsAirsoftModel(qty: 0));
  RxBool isLoading = false.obs;
  RxList<CartModel> cart = <CartModel>[].obs;
  RxInt totalPrice = 0.obs;

  Repository repo = Get.find<Repository>();
  HomepageController homepageController = Get.find<HomepageController>();
  StatsController statsController = Get.find<StatsController>();

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
  void addItemToCart(CartModel airsoft) {
    airsoft.qty = 1;
    cart.add(airsoft);

    List<Map<String, dynamic>> items_cart =
        cart.map((CartModel e) => e.toJson()).toList();

    box.write('items_cart', items_cart);
  }

  void calcAllItemTotalPrice() {
    for (int i = 0; i < cart.length; i++) {
      totalPrice.value = totalPrice.value + (cart[i].qty * cart[i].price!);
    }
  }

  void getLastSessionData() {
    if (box.hasData('items_cart')) {
      List<dynamic> sessionData = box.read('items_cart');
      if (sessionData is List) {
        List<CartModel> dataInModel =
            sessionData.map((e) => CartModel.fromJson(e)).toList();
        cart.clear();
        cart.addAll(dataInModel);
        calcAllItemTotalPrice();
      }
      listerForUpdate();
    }
  }

  void listerForUpdate() {
    box.listenKey('items_cart', (value) {
      logger.i('Perubahan terjadi pada cart $value');
      if (value is List) {
        List<CartModel> dataInModel =
            value.map((e) => CartModel.fromJson(e)).toList();
        cart.clear();
        cart.addAll(dataInModel);
        calcAllItemTotalPrice();
      }
    });
  }

  void removeRecordFromCart(int id) {
    cart.removeWhere((element) => element.id == id);
    List<Map<String, dynamic>> items_cart =
        cart.map((element) => element.toJson()).toList();

    box.write('items_cart', items_cart);
  }

  void increaseQtyOfItemInCart(CartModel airsoft) {
    cart.removeWhere((element) => element.id == airsoft.id);
    airsoft.qty++;
    cart.add(airsoft);
    List<Map<String, dynamic>> items_cart =
        cart.map((element) => element.toJson()).toList();

    box.write('items_cart', items_cart);
  }

  void decreaseQtyOfItemInCart(CartModel airsoft) {
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

  // When transaction has been made,
  // clear the session, set grandTotal to zero
  // remove the dialog and show the snackbar

  List<Items> listOfItems = [];

  void transactionCompleted() {
    isLoading.value = true;

    listOfItems.addAll(cart
        .map((CartModel e) => Items(
              id: e.id,
              name: e.name,
              qty: e.qty,
              price: e.price,
              image: e.photo,
            ))
        .toList());

    try {
      repo.postTransaction(items: listOfItems).then((value) {
        if (value.success!) {
          box.write("items_cart", []);
          cart.clear();
          Get.offAllNamed(AppRoutes.masterRoute);
          statsController.getAllTransactionData();
          Get.snackbar(
            'Selamat',
            'Transaksi berhasil dengan No, ${value.data!.transCode}',
            backgroundColor: const Color(0xff4D4D4D),
          );
        }
        isLoading.value = false;
      });
    } catch (e, stackTrace) {
      logger.e(e.toString());
      logger.e(stackTrace.toString());
    }
  }

  @override
  void onReady() {
    super.onReady();
    getLastSessionData();
  }
}
