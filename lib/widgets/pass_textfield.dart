import 'package:flutter/material.dart';
// import 'package:flutter_animator/flutter_animator.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_stenly_rachmad/global/constants.dart';

import 'package:tugas_akhir_stenly_rachmad/pages/auth/auth_controller.dart';

class PasswordTextField extends StatelessWidget {
  final String label;
  final Widget icon;
  final TextEditingController textEditingController;

  PasswordTextField({
    Key? key,
    required this.label,
    required this.icon,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.find<AuthController>();

    return Padding(
      padding:
          const EdgeInsets.only(top: 10, left: 40.0, right: 40.0, bottom: 20.0),
      child: Obx(
        () => TextFormField(
          validator: (value) => value!.isEmpty ? 'Tidak boleh kosong' : null,
          controller: textEditingController,
          obscureText: controller.isObsecure.value,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
            ),
            suffixIcon: IconButton(
              onPressed: () => controller.toggleObsecure(),
              icon: controller.isObsecure.value
                  ? Icon(
                      Icons.visibility_off,
                      color: Colors.white,
                    )
                  : Icon(
                      Icons.visibility,
                      color: Colors.white,
                    ),
            ),
            prefixIcon: icon,
            border: kInputBorder,
            enabledBorder: kInputBorder,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            floatingLabelStyle: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
