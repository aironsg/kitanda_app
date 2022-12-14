import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitanda_app/app/src/pages/auth/controller/auth_controller.dart';
import 'package:kitanda_app/app/src/pages/common_widgets/app_name_widget.dart';
import 'package:kitanda_app/app/src/pages/common_widgets/custom_form_field.dart';
import 'package:kitanda_app/app/src/config/custom_color.dart';
import 'package:kitanda_app/app/src/pages/common_widgets/forgot_password_dialog.dart';
import 'package:kitanda_app/app/src/pages_routers/app_pages.dart';
import 'package:kitanda_app/app/src/services/utils_service.dart';
import 'package:kitanda_app/app/src/services/validators.dart' as validator;

// ignore: must_be_immutable
class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  UtilsService utilsService = UtilsService();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColor.customSwatchColor[900],
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // titulo do app
                    const AppNameWidget(
                      greenTitleColor: Colors.white,
                      textSize: 40,
                    ),
                    // categorias do app
                    SizedBox(
                      height: 30.0,
                      child: DefaultTextStyle(
                        style: TextStyle(
                          color: CustomColor.customCategoryColor[900],
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                        child: AnimatedTextKit(
                          pause: const Duration(seconds: 1),
                          repeatForever: true,
                          animatedTexts: [
                            FadeAnimatedText('Frutas',
                                duration: const Duration(seconds: 2)),
                            FadeAnimatedText('Carnes',
                                duration: const Duration(seconds: 2)),
                            FadeAnimatedText('Lactcinios',
                                duration: const Duration(seconds: 2)),
                            FadeAnimatedText('Verduras',
                                duration: const Duration(seconds: 2)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //Formulario
              Container(
                //inicio decora????o container
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 40.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(45.0),
                  ),
                ),
                //fim decora????o container
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //Email
                      CustomFormField(
                        controller: _emailEC,
                        inputType: TextInputType.emailAddress,
                        label: 'Email',
                        hint: 'fulano@email.com',
                        icon: const Icon(Icons.email_outlined),
                        validator: validator.emailValidator,
                      ),

                      //password
                      CustomFormField(
                        controller: _passwordEC,
                        inputType: TextInputType.text,
                        label: 'password',
                        hint: 'password forte',
                        icon: const Icon(Icons.lock_outline), //prefixx
                        isSecret: true,
                        validator: validator.passwordValidator,
                      ),

                      //Bot??o Entrar
                      SizedBox(
                        height: 50.0,
                        child: GetX<AuthController>(
                          builder: (authController) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              )),
                              onPressed: authController.isLoading.value
                                  ? null
                                  : () async {
                                      //logica de token
                                      FocusScope.of(context).unfocus();
                                      if (_formKey.currentState!.validate()) {
                                        String email = _emailEC.text;
                                        String password = _passwordEC.text;
                                        await authController.signIn(
                                            email: email, password: password);
                                      }
                                    },
                              child: authController.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                      'Entrar',
                                      style: TextStyle(
                                          fontSize: 16.0, color: Colors.white),
                                    ),
                            );
                          },
                        ),
                      ),

                      //Bot??o Esqueci a password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () async {
                            final bool? result = await showDialog(
                              context: context,
                              builder: (_) {
                                return ForgotPasswordDialog(
                                    email: _emailEC.text);
                              },
                            );

                            if (result ?? false) {
                              utilsService.showToast(
                                  message:
                                      'Um Link de confirma????o foi enviado para seu email');
                            }
                          },
                          child: Text(
                            'Esqueci a password',
                            style: TextStyle(
                              color: CustomColor.customContrasctColor,
                            ),
                          ),
                        ),
                      ),

                      //Divisor
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                'Ou',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            )
                          ],
                        ),
                      ),

                      //Bot??o Criar Conta
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 3,
                              side: BorderSide(
                                  width: 2,
                                  color: CustomColor.customSwatchColor),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              )),
                          onPressed: () {
                            Get.toNamed(PageRoutes.signUpRouter);
                          },
                          child: Text(
                            'Criar Conta',
                            style: TextStyle(
                                fontSize: 18.0,
                                color: CustomColor.customSwatchColor[900]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
