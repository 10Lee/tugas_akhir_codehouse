import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_stenly_rachmad/config/dimensions.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/update/update_controller.dart';

class UpdatePage extends StatelessWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UpdateController controller = Get.find<UpdateController>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Update Airsoft")),
        body: Padding(
          padding: EdgeInsets.all(Dimensions.height30),
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
                            child: Image(
                              errorBuilder: (context, _, __) => Image.network(
                                'https://www.sragenkab.go.id/assets/images/image-not-available-.jpg',
                                fit: BoxFit.cover,
                              ),
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                '${controller.uploadImageUrl}',
                              ),
                            ),
                          ),
                        ),
                  SizedBox(height: Dimensions.height60),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.updateAirsoftData(
                          name: controller.nameInputController.text,
                          price: controller.priceInputController.text,
                          description:
                              controller.descriptionInputController.text,
                        );
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.orange),
                      child: controller.isLoading.value
                          ? Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.width20),
                                child: const LinearProgressIndicator(
                                    color: Colors.white),
                              ),
                            )
                          : const Text('Update'),
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
