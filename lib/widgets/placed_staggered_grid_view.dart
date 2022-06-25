import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_stenly_rachmad/app_routes.dart';
import 'package:tugas_akhir_stenly_rachmad/config/dimensions.dart';
import 'package:tugas_akhir_stenly_rachmad/global/constants.dart';
import 'package:tugas_akhir_stenly_rachmad/models/get_api/result_airsoft_model.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/detail/detail_controller.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/home/homepage_controller.dart';

import '../config/logger.dart';
import '../global/formatter.dart';

// import '../models/data/sample_airsoft_list.dart';

class PlacedStaggeredGridView extends StatelessWidget {
  final List<ResultsAirsoftModel> apiData;
  final HomepageController controller;

  const PlacedStaggeredGridView({
    Key? key,
    required this.apiData,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DetailController detailController = Get.find<DetailController>();

    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
        child: controller.isLoading.value && controller.listOfAirsoft.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : StaggeredGridView.countBuilder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 4,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                itemCount: controller.isNoMoreLoad.value
                    ? apiData.length
                    : apiData.length + 1,
                // itemCount: apiData.length,
                itemBuilder: (context, index) {
                  if (index < apiData.length) {
                    // final itemSorted = apiData
                    //   ..sort((item1, item2) => item2.id!.compareTo(item1.id!));
                    // final item = itemSorted[index];
                    final item = apiData[index];

                    return _buildCard(item, detailController);
                  } else {
                    // return const Padding(
                    //   padding: EdgeInsets.all(20.0),
                    //   child: Center(
                    //     child: LinearProgressIndicator(),
                    //   ),
                    // );
                    return const SizedBox();
                  }
                },
                staggeredTileBuilder: (_) => const StaggeredTile.fit(2),
              ),
      ),
    );
  }

  InkWell _buildCard(
      ResultsAirsoftModel item, DetailController detailController) {
    return InkWell(
      onTap: () {
        logger.e(item.id.toString());
        detailController.callDetailApi(item.id);
        Get.toNamed(
          AppRoutes.detailRoute,
        );
      },
      child: Stack(
        children: [
          Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.radius8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: item.id.toString(),
                    child: Image.network(
                      '${kImageUrl}/${item.photo}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, _, __) {
                        return Image.network(
                          'https://www.sragenkab.go.id/assets/images/image-not-available-.jpg',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.height10,
                        vertical: Dimensions.width10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${item.name}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.font18),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: Dimensions.height10),
                        Text(
                          'Rp. ${Formatter.format.format(item.price)}',
                          style: TextStyle(fontSize: Dimensions.font15),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Positioned(
          //   top: 5.0,
          //   right: 5.0,
          //   child: InkWell(
          //     onTap: () => controller.deleteAirsoft(item.id!),
          //     child: Container(
          //       width: 30.0,
          //       height: 30.0,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(30.0),
          //         color: Colors.black87,
          //       ),
          //       child: Icon(Icons.close),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
