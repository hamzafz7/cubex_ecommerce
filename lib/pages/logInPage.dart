import 'package:cubex_ecommerce/common/widgets/custom_button.dart';
import 'package:cubex_ecommerce/common/widgets/custom_textfield.dart';
import 'package:cubex_ecommerce/controllers/authController.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LogInPage extends StatelessWidget {
  LogInPage({super.key});
  final formkey = GlobalKey<FormState>();
  AuthController authControlar = Get.put(AuthController());
  TextEditingController emailc = TextEditingController();
  TextEditingController passwordc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              "login".tr,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 37,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Form(
                      autovalidateMode: AutovalidateMode.disabled,
                      key: formkey,
                      child: Column(
                        children: [
                          CustomTextField(
                            maxLines: 1,
                            hintText: "email",
                            icon: const Icon(Icons.email),
                            keyboardType: TextInputType.emailAddress,
                            validator: (e) {
                              return authControlar.validateEmail(e);
                            },
                            controller: emailc,
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          CustomTextField(
                            controller: passwordc,
                            icon: const Icon(Icons.password),
                            validator: (e) {
                              return authControlar.validatePassword(e);
                            },
                            hintText: "password",
                            keyboardType: TextInputType.visiblePassword,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                      title: "login".tr,
                      onTap: () {
                        formkey.currentState!.save();
                        formkey.currentState!.validate();
                        if (formkey.currentState!.validate()) {
                          authControlar.email = emailc.text;
                          authControlar.password = passwordc.text;
                          print(authControlar.email);
                          print(authControlar.password);
                        } else {
                          Get.snackbar(
                              "error", " error in username or password");
                        }
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    child: Text(
                      "forget".tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomButton(
                      title: "register".tr,
                      buttonColor: Colors.orangeAccent,
                      onTap: () {})
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
