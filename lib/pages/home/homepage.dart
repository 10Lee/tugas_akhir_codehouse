import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_stenly_rachmad/config/dimensions.dart';
import 'package:tugas_akhir_stenly_rachmad/config/logger.dart';
import 'package:tugas_akhir_stenly_rachmad/global/constants.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/home/homepage_controller.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/master_controller.dart';
import 'package:tugas_akhir_stenly_rachmad/widgets/cart_iconbutton.dart';
import 'package:tugas_akhir_stenly_rachmad/widgets/main_carousel.dart';
import 'package:tugas_akhir_stenly_rachmad/widgets/placed_staggered_grid_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomepageController homepageController = Get.find<HomepageController>();
    MasterController controller = Get.find<MasterController>();

    return Scaffold(
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.metrics.pixels ==
                notification.metrics.maxScrollExtent) {
              if (homepageController.isNoMoreLoad.value == false) {
                if (homepageController.isLoading.value == false) {
                  homepageController.page++;
                  homepageController.callApi();
                  // logger.e("MENTOK");
                }
              }
            }
            return true;
          },
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20,
                    vertical: Dimensions.height10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Halo,"),
                          Text(controller.userName.toString().capitalizeFirst!,
                              style: TextStyle(fontSize: Dimensions.font20)),
                        ],
                      ),
                    ),
                    const CartIconButton(),
                    SizedBox(width: Dimensions.width30),
                    PopupMenuButton(
                      onSelected: (value) {
                        switch (value) {
                          case 'logout':
                            controller.logoutAccount();
                            break;
                        }
                      },
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: Row(
                              children: [
                                Icon(Icons.power_settings_new),
                                SizedBox(width: Dimensions.width10),
                                Text("Logout"),
                              ],
                            ),
                            value: 'logout',
                          ),
                        ];
                      },
                      child: CircleAvatar(
                        radius: Dimensions.radius20,
                        backgroundImage: const NetworkImage(
                            'https://images.unsplash.com/photo-1599834562135-b6fc90e642ca?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20),
              const MainCarousel(),
              SizedBox(height: Dimensions.height50),
              Row(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: Dimensions.width20),
                    child: Text(
                      'Daftar Produk',
                      style: TextStyle(
                        fontSize: Dimensions.font24,
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: Dimensions.width5),
                  Container(
                    // width: getMediaQuery(context, MediaQueryTypes.width) / 2.25,
                    width: Dimensions.screenWidth / 2.25,
                    height: .5,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(height: Dimensions.height50),
              PlacedStaggeredGridView(
                apiData: homepageController.listOfAirsoft,
                controller: homepageController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
