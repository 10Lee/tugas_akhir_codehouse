import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_stenly_rachmad/app_routes.dart';
import 'package:tugas_akhir_stenly_rachmad/config/dimensions.dart';
import 'package:tugas_akhir_stenly_rachmad/global/constants.dart';
import 'package:tugas_akhir_stenly_rachmad/global/formatter.dart';
import 'package:tugas_akhir_stenly_rachmad/models/get_api/result_airsoft_model.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/detail/detail_controller.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/home/homepage_controller.dart';
import 'package:tugas_akhir_stenly_rachmad/widgets/cart_iconbutton.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DetailController detailController = Get.find<DetailController>();
    return Obx(
      () {
        ResultsAirsoftModel data = detailController.detailData.value;
        return detailController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width10,
                        vertical: Dimensions.height10),
                    child: Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius30),
                      ),
                      child: IconButton(
                        onPressed: () => Get.offAllNamed(AppRoutes.masterRoute),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 20.0,
                        ),
                        padding: const EdgeInsets.only(left: 7.0),
                      ),
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: Dimensions.height50),
                        child: Hero(
                          tag: data.id.toString(),
                          child: Image.network(
                            '$kImageUrl/${data.photo}',
                            errorBuilder: (context, _, __) => Image.network(
                                'https://www.sragenkab.go.id/assets/images/image-not-available-.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Divider(
                          height: 8.0, color: Colors.white, thickness: 2.0),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width20,
                            vertical: Dimensions.height20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "${data.name}",
                                    style:
                                        TextStyle(fontSize: Dimensions.font30),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: Dimensions.width20),
                                const CartIconButton(),
                                SizedBox(width: Dimensions.width20),
                                PopupMenuButton(
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit),
                                          SizedBox(width: Dimensions.width10),
                                          Text("Edit"),
                                        ],
                                      ),
                                      value: 'edit',
                                    ),
                                    PopupMenuItem(
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete),
                                          SizedBox(width: Dimensions.width10),
                                          Text("Delete"),
                                        ],
                                      ),
                                      value: 'delete',
                                    ),
                                  ],
                                  child: const Icon(Icons.more_vert),
                                  onSelected: (val) {
                                    switch (val) {
                                      case 'edit':
                                        Get.toNamed(
                                          AppRoutes.updateRoute,
                                          arguments: {
                                            'id_input': data.id,
                                            'name_input': data.name,
                                            'price_input':
                                                data.price.toString(),
                                            'desc_input': data.description,
                                            'file_input':
                                                '$kImageUrl/${data.photo}',
                                          },
                                        );
                                        break;
                                      case 'delete':
                                        // detailController
                                        //     .deleteAirsoft(data.id!);
                                        // Get.back();

                                        Get.defaultDialog(
                                          title: "Konfirmasi",
                                          content: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Dimensions.width10,
                                                vertical: Dimensions.height10),
                                            child: const Center(
                                              child: Text(
                                                  "Apakah anda yakin ingin menghapus airsoft ini?"),
                                            ),
                                          ),
                                          onCancel: () => Get.back(),
                                          onConfirm: () {
                                            detailController
                                                .deleteAirsoft(data.id!);
                                            Get.offAllNamed(
                                                AppRoutes.masterRoute);
                                          },
                                        );
                                    }
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            Text("Rp. ${Formatter.format.format(data.price)}",
                                style: TextStyle(
                                    fontSize: Dimensions.font15,
                                    color: Colors.lightGreen,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 30.0),
                            Text(
                              '${data.description}',
                              style: TextStyle(fontSize: Dimensions.font20),
                            ),
                            SizedBox(height: Dimensions.height30),
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Obx(
                                    () {
                                      ResultsAirsoftModel? cartInList =
                                          detailController.cart
                                              .firstWhereOrNull(
                                        (element) => element.id == data.id,
                                      );

                                      if (cartInList == null) {
                                        return ElevatedButton.icon(
                                          onPressed: () => detailController
                                              .addItemToCart(data),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.green),
                                          icon: Icon(Icons.add_shopping_cart),
                                          label: const Text(
                                            'Masukan Keranjang',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        );
                                      } else {
                                        return _inCartMode(
                                            cartInList, detailController);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height50,
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }

  Widget _inCartMode(
      ResultsAirsoftModel cartInList, DetailController controller) {
    return BounceInRight(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  controller.decreaseQtyOfItemInCart(cartInList);
                },
                child: Container(
                  width: Dimensions.width40,
                  height: Dimensions.height30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                  ),
                  child: const Icon(
                    Icons.remove,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 5.0),
              GetBuilder<DetailController>(
                init: DetailController(),
                builder: (_) {
                  return Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: Dimensions.width10),
                    height: 40.0,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius30),
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        )),
                    child: Center(
                      child: Text(
                        "${cartInList.qty} pcs",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 5.0),
              InkWell(
                onTap: () => controller.increaseQtyOfItemInCart(cartInList),
                child: Container(
                  width: 40.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.height20),
          ElevatedButton.icon(
            onPressed: () => controller.removeRecordFromCart(cartInList.id!),
            style: ElevatedButton.styleFrom(primary: Colors.red),
            label: const Text("Hapus dari keranjang"),
            icon: const Icon(Icons.remove_shopping_cart),
          ),
        ],
      ),
    );
  }
}
