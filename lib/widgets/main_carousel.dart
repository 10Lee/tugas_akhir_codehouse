import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tugas_akhir_stenly_rachmad/config/dimensions.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/home/homepage_controller.dart';

import '../models/data/sample_airsoft_list.dart';

class MainCarousel extends StatefulWidget {
  const MainCarousel({Key? key}) : super(key: key);

  @override
  State<MainCarousel> createState() => _MainCarouselState();
}

class _MainCarouselState extends State<MainCarousel> {
  PageController pageController = PageController(viewportFraction: .8);
  var currPageValue = 0.0;
  double scaleFactor = .8;
  double height = 300;

  @override
  void initState() {
    super.initState();

    pageController.addListener(
        () => setState(() => currPageValue = pageController.page!));
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomepageController controller = Get.find<HomepageController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: Dimensions.width400,
          height: Dimensions.height300,
          child: PageView.builder(
            controller: pageController,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: listOfHotItem.length,
            itemBuilder: (context, index) {
              final hotItem = listOfHotItem[index];
              final frontInfo = frontInfoItems[index];

              Matrix4 matrix = Matrix4.identity();
              if (index == currPageValue.floor()) {
                var currScale = 1 - (currPageValue - index) * (1 - scaleFactor);

                var currTrans = height * (1 - currScale) / 2;

                matrix = Matrix4.diagonal3Values(1, currScale, 1)
                  ..setTranslationRaw(0, currTrans, 0);
              } else if (index == currPageValue.floor() + 1) {
                var currScale = scaleFactor +
                    (currPageValue - index + 1) * (1 - scaleFactor);

                var currTrans = height * (1 - currScale) / 2;

                matrix = Matrix4.diagonal3Values(1, currScale, 1)
                  ..setTranslationRaw(0, currTrans, 0);
              } else if (index == currPageValue.floor() - 1) {
                var currScale = 1 - (currPageValue - index) * (1 - scaleFactor);

                var currTrans = height * (1 - currScale) / 2;

                matrix = Matrix4.diagonal3Values(1, currScale, 1)
                  ..setTranslationRaw(0, currTrans, 0);
              } else {
                var currScale = 0.8;

                var currTrans = height * (1 - scaleFactor) / 2;

                matrix = Matrix4.diagonal3Values(1, currScale, 1)
                  ..setTranslationRaw(0, currTrans, 0);
              }

              return Transform(
                transform: matrix,
                child: Stack(
                  children: [
                    _buildlistOfHotItem(context, hotItem),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(bottom: Dimensions.height40),
                        width: Dimensions.width230,
                        height: Dimensions.height100,
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius30),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                color: Colors.black.withOpacity(.8),
                                offset: Offset(.5, 2),
                              ),
                            ]),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.width10,
                              vertical: Dimensions.height10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${frontInfo.title}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Dimensions.font20,
                                    fontWeight: FontWeight.w600),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Wrap(
                                    children: List.generate(
                                      5,
                                      (index) => const Icon(
                                        Icons.star,
                                        color: Colors.lightBlue,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${frontInfo.rating} | ",
                                    style:
                                        TextStyle(fontSize: Dimensions.font15),
                                  ),
                                  Text(
                                    "${frontInfo.comments} comments",
                                    style:
                                        TextStyle(fontSize: Dimensions.font15),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.circle_sharp,
                                    color: Colors.orange,
                                  ),
                                  Text(
                                    "Normal",
                                    style:
                                        TextStyle(fontSize: Dimensions.font12),
                                  ),
                                  SizedBox(width: Dimensions.width10),
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.lightBlue,
                                  ),
                                  Text(
                                    "2Km",
                                    style:
                                        TextStyle(fontSize: Dimensions.font12),
                                  ),
                                  SizedBox(width: Dimensions.width10),
                                  const Icon(
                                    Icons.access_time_rounded,
                                    color: Colors.red,
                                  ),
                                  Text(
                                    "2min",
                                    style:
                                        TextStyle(fontSize: Dimensions.font12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        // Dotted page indicator
        SmoothPageIndicator(
          controller: pageController,
          count: listOfHotItem.length,
          effect: const SlideEffect(
            dotWidth: 10.0,
            dotHeight: 10.0,
            dotColor: Colors.grey,
            activeDotColor: Colors.blue,
            radius: 20.0,
            spacing: 5,
          ),
        ),
      ],
    );
  }

  Widget _buildlistOfHotItem(BuildContext context, hotItem) {
    return Container(
      width: Dimensions.width300,
      height: Dimensions.height200,
      margin:
          EdgeInsets.only(top: Dimensions.height10, right: Dimensions.width12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius15),
        border: Border.all(
          width: .15,
          color: Colors.grey.shade200,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimensions.radius15),
        child: Image.network(hotItem.photo, fit: BoxFit.cover),
      ),
    );
  }
}
