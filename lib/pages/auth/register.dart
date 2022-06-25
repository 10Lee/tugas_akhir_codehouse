import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tugas_akhir_stenly_rachmad/config/dimensions.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/auth/auth_controller.dart';
import 'package:tugas_akhir_stenly_rachmad/widgets/pass_textfield.dart';
import 'package:tugas_akhir_stenly_rachmad/widgets/reg_textfield.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.find<AuthController>();

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Form(
            key: _globalKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Center(
                  child: Image.asset('assets/gif/signup.gif',
                      width: Dimensions.imageHeight200),
                ),
                SizedBox(height: Dimensions.height40),
                FadeInDown(
                  preferences: const AnimationPreferences(
                      duration: Duration(seconds: 1)),
                  child: Center(
                    child: Text(
                      "Registrasi",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.font22),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.height10),
                FadeInDown(
                  preferences: const AnimationPreferences(
                    duration: Duration(seconds: 1),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: Dimensions.width20),
                    child: Text(
                      "Silahkan mengisi formulir berikut untuk mendaftarkan akun baru",
                      style: TextStyle(fontSize: Dimensions.font18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.height20),
                RegularTextField(
                  textEditingController: controller.usernameController,
                  label: 'Username',
                  icon: Icon(Iconsax.user,
                      color: Colors.white, size: Dimensions.font18),
                ),
                RegularTextField(
                  textEditingController: controller.emailController,
                  label: 'Email',
                  icon: Icon(Icons.email_outlined,
                      color: Colors.white, size: Dimensions.font18),
                ),
                PasswordTextField(
                  textEditingController: controller.passwordController,
                  label: 'Password',
                  icon: Icon(Iconsax.key,
                      color: Colors.white, size: Dimensions.font18),
                ),
                FadeInUp(
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: Dimensions.height150),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_globalKey.currentState!.validate()) {
                          controller.submitAccount();
                        }
                      },
                      child: const Text("Daftar"),
                    ),
                  ),
                ),
                FadeInUp(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Sudah punya akun?"),
                      TextButton(
                          onPressed: () => Get.offAllNamed('/login'),
                          child: const Text("Login yuk"))
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.height40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
