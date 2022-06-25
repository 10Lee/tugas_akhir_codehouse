import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:tugas_akhir_stenly_rachmad/app_routes.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/master_controller.dart';

class MasterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MasterController controller = Get.find<MasterController>();

    return Obx(
      () => Scaffold(
        body: controller.pages[controller.currentIndex.value],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlue,
          onPressed: () => Get.offAllNamed(AppRoutes.addRoute),
          child: const FaIcon(
            FontAwesomeIcons.gun,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.home,
                  color: controller.currentIndex.value == 0
                      ? Colors.blue
                      : Colors.white,
                ),
                onPressed: () => controller.currentIndex.value = 0,
              ),
              const SizedBox(width: 48.0),
              IconButton(
                icon: Icon(
                  Icons.show_chart,
                  color: controller.currentIndex.value == 1
                      ? Colors.blue
                      : Colors.white,
                ),
                onPressed: () => controller.currentIndex.value = 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
