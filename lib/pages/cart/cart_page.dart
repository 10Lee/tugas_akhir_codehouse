import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_stenly_rachmad/config/dimensions.dart';
import 'package:tugas_akhir_stenly_rachmad/global/constants.dart';
import 'package:tugas_akhir_stenly_rachmad/global/formatter.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/cart/cart_controller.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/detail/detail_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartController controller = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang Belanja"),
      ),
      body: Obx(
        () => controller.cart.isEmpty
            ? Center(
                child: Text("Keranjang Kosong",
                    style: TextStyle(fontSize: Dimensions.font18)),
              )
            : Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.cart.length,
                        itemBuilder: (context, index) {
                          var cartData = controller.cart[index];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft:
                                        Radius.circular(Dimensions.radius15),
                                    bottomLeft:
                                        Radius.circular(Dimensions.radius15),
                                  ),
                                  child: Image(
                                    width: Dimensions.width100,
                                    height: Dimensions.height100 + 5,
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      '$kImageUrl/${cartData.photo}',
                                    ),
                                    errorBuilder: (context, _, __) =>
                                        Image.network(
                                      'https://www.sragenkab.go.id/assets/images/image-not-available-.jpg',
                                      fit: BoxFit.fitHeight,
                                      height: Dimensions.height100 + 5,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: Dimensions.height100 + 8,
                                    color: Colors.white.withOpacity(.05),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Dimensions.width12,
                                          vertical: Dimensions.height12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  cartData.name.toString(),
                                                  style: TextStyle(
                                                      fontSize:
                                                          Dimensions.font18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.left,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(width: 8.0),
                                              InkWell(
                                                onTap: () => controller
                                                    .removeRecordFromCart(
                                                        cartData.id!),
                                                child: Container(
                                                  width: Dimensions.width12,
                                                  height: Dimensions.height12,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      Dimensions.radius30,
                                                    ),
                                                  ),
                                                  child: const Icon(
                                                    Icons.close,
                                                    size: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Tickets :",
                                                style: TextStyle(
                                                  fontSize: Dimensions.font15,
                                                ),
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                  width: Dimensions.width20),
                                              Text(
                                                "${cartData.qty}",
                                                style: TextStyle(
                                                    fontSize: Dimensions.font22,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            'Rp. ${Formatter.format.format(cartData.qty * cartData.price!)}',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () => controller
                                          .decreaseQtyOfItemInCart(cartData),
                                      child: Container(
                                        width: Dimensions.width50,
                                        height: Dimensions.height50,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(
                                                  Dimensions.radius20),
                                            )),
                                        child: const Icon(Icons.remove),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    InkWell(
                                      onTap: () => controller
                                          .increaseQtyOfItemInCart(cartData),
                                      child: Container(
                                        width: 50.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(
                                                  Dimensions.radius20),
                                            )),
                                        child: const Icon(Icons.add),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          _showConfirmDialog(controller);
                        },
                        child: Container(
                          width: double.infinity,
                          height: Dimensions.height50,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30)),
                          child: Center(
                            child: Text(
                              "Purchase",
                              style: TextStyle(
                                  fontSize: Dimensions.font18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.height20),
                  ],
                ),
              ),
      ),
    );
  }

  void _showConfirmDialog(CartController controller) {
    Get.defaultDialog(
      title: "Silahkan cek kembali sebelum melakukan transaksi",
      actions: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
          ),
          onPressed: () {
            Get.back();
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.yellow)),
            onPressed: () {
              controller.transactionCompleted();
            },
            child: controller.isLoading.value
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimensions.height30,
                          horizontal: Dimensions.width30),
                      child: LinearProgressIndicator(),
                    ),
                  )
                : const Text(
                    "Confirm",
                    style: TextStyle(color: Colors.black),
                  ))
      ],
      backgroundColor: Color(0xff4D4D4D),
      titleStyle: TextStyle(
          color: Colors.white,
          fontFamily: 'Poppins',
          fontSize: Dimensions.font18,
          fontWeight: FontWeight.bold),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Dimensions.width300,
            height: Dimensions.height200,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (_, i) => Divider(),
              itemCount: controller.cart.length,
              itemBuilder: (_, index) {
                return ListTile(
                  leading: Container(
                    width: Dimensions.width60,
                    height: Dimensions.height60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(Dimensions.radius10)),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          '$kImageUrl/${controller.cart[index].photo!}',
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    controller.cart[index].name!,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.font18),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                      "Rp. ${Formatter.format.format(controller.cart[index].price)} x ${controller.cart[index].qty} pcs"),
                );
              },
            ),
          ),
          SizedBox(height: Dimensions.height30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
            child: Text(
              "Name: " + controller.userSession["name"].toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.font12),
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width15),
            child: Text(
              "Email : " + controller.userSession["email"].toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.font12),
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width15),
            child: Text(
              "Grand Total : Rp. ${Formatter.format.format(controller.totalPrice.value)}",
              style: TextStyle(
                  color: Colors.lightGreen,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.font12),
            ),
          ),
        ],
      ),
    );
  }
}
