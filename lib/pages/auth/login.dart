import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_animator/flutter_animator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tugas_akhir_stenly_rachmad/config/dimensions.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/auth/auth_controller.dart';
import 'package:tugas_akhir_stenly_rachmad/widgets/pass_textfield.dart';
import 'package:tugas_akhir_stenly_rachmad/widgets/reg_textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.find<AuthController>();

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Center(
                  child: Image.asset('assets/gif/login.gif',
                      width: Dimensions.imageWidth300),
                ),
                SizedBox(height: Dimensions.height40),
                // FadeInDown(
                // preferences: const AnimationPreferences(
                // duration: Duration(seconds: 1)),
                Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.font22),
                  ),
                ),
                // ),
                SizedBox(height: Dimensions.height10),
                // FadeInDown(
                //   preferences: const AnimationPreferences(
                //     duration: Duration(seconds: 1),
                //   ),
                Text(
                  "Silahkan gunakan akun anda untuk login",
                  style: TextStyle(fontSize: Dimensions.font18),
                  textAlign: TextAlign.center,
                ),
                // ),
                SizedBox(height: Dimensions.height20),
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
                // FadeInUp(
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.width150),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.submitAccount(isLogin: true);
                      }
                    },
                    child: const Text("Login"),
                  ),
                ),
                // ),
                // FadeInUp(
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Belum punya akun?"),
                    TextButton(
                        onPressed: () => Get.offAllNamed('/register'),
                        child: const Text("Daftar yuk"))
                  ],
                ),
                // ),
                SizedBox(height: Dimensions.height40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
