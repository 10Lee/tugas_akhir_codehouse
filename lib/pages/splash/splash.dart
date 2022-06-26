import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_animator/flutter_animator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_stenly_rachmad/config/dimensions.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/auth/auth_controller.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/splash/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SplashController controller = Get.find<SplashController>();

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // width: Dimensions.width100,
                width: Dimensions.width100,
                height: Dimensions.height100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child:
                      FaIcon(FontAwesomeIcons.gun, size: Dimensions.iconSize45),
                ),
              ),
              SizedBox(width: Dimensions.width10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: Dimensions.font30,
                        fontWeight: FontWeight.bold,
                      ),
                      children: const [
                        TextSpan(text: 'Airsoft'),
                        TextSpan(
                            text: 'Fun', style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.height5),
                  const Text('Koleksi Airsoft kesukaanmu'),
                ],
              ),
            ],
          ),
          SizedBox(height: Dimensions.height20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width165),
            child: const LinearProgressIndicator(),
          ),
        ],
      ),
    ));
  }
}
