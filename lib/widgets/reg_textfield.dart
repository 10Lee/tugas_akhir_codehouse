import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_animator/flutter_animator.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_stenly_rachmad/global/constants.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/auth/auth_controller.dart';

class RegularTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String label;
  final Widget icon;
  final TextInputType keyboardType;

  RegularTextField({
    Key? key,
    required this.textEditingController,
    required this.label,
    required this.icon,
    this.keyboardType = TextInputType.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.find<AuthController>();

    return Padding(
      padding:
          const EdgeInsets.only(top: 10, left: 40.0, right: 40.0, bottom: 20.0),
      child: TextFormField(
        keyboardType: keyboardType,
        validator: (value) => value!.isEmpty ? 'Tidak boleh kosong' : null,
        controller: textEditingController,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
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
    );
  }
}
