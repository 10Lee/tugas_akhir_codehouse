import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/detail/detail_controller.dart';

import '../app_routes.dart';

class CartIconButton extends StatelessWidget {
  const CartIconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DetailController controller = Get.find<DetailController>();

    return Obx(
      () => InkWell(
        onTap: () => Get.toNamed(AppRoutes.cartRoute),
        child: controller.cart.length == 0
            ? Icon(Icons.shopping_cart)
            : Badge(
                padding: const EdgeInsets.all(1),
                child: const Icon(Icons.shopping_cart),
                badgeColor: Colors.red,
                position: BadgePosition(bottom: 10.0, end: -10),
                badgeContent: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    '${controller.cart.length}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
