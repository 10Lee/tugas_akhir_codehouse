import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_stenly_rachmad/app_routes.dart';
import 'package:tugas_akhir_stenly_rachmad/config/dimensions.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/add/add_controller.dart';

class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddController controller = Get.find<AddController>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Airsoft"),
          leading: IconButton(
            onPressed: () => Get.offAllNamed(AppRoutes.masterRoute),
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width30, vertical: Dimensions.height30),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: controller.nameInputController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                  ),
                  SizedBox(height: Dimensions.height30),
                  TextField(
                    controller: controller.priceInputController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Price'),
                  ),
                  SizedBox(height: Dimensions.height30),
                  TextField(
                    controller: controller.descriptionInputController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  SizedBox(height: Dimensions.height30),
                  Text(
                    'Photo',
                    style: TextStyle(
                        color: Colors.white60, fontSize: Dimensions.font15),
                  ),
                  SizedBox(height: Dimensions.height30),
                  controller.fileImagePicker.value.existsSync()
                      ? InkWell(
                          onTap: () => controller.getImage(),
                          child: Container(
                            width: double.infinity,
                            height: Dimensions.height150,
                            color: Colors.grey,
                            child: Image(
                              fit: BoxFit.cover,
                              image:
                                  FileImage(controller.fileImagePicker.value),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () => controller.getImage(),
                          child: Container(
                            width: double.infinity,
                            height: Dimensions.height150,
                            color: Colors.grey,
                            child: const Image(
                              image: NetworkImage(
                                  'https://www.sragenkab.go.id/assets/images/image-not-available-.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  SizedBox(height: Dimensions.height60),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.postNewAirsoft(
                          name: controller.nameInputController.text,
                          price: controller.priceInputController.text,
                          description:
                              controller.descriptionInputController.text,
                        );
                      },
                      child: controller.isLoading.value
                          ? Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.width50),
                                child: const LinearProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : const Text('Add New AirsoftGun'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
