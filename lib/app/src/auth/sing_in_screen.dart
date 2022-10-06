import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:kitanda_app/app/src/auth/components/custom_form_field.dart';
import 'package:kitanda_app/app/src/auth/config/custom_color.dart';
import 'package:get/get.dart';

class SingInScreen extends StatelessWidget {
  const SingInScreen({Key? key}) : super(key: key);

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
                    Text.rich(
                      TextSpan(
                        style: const TextStyle(fontSize: 40),
                        children: [
                          const TextSpan(
                            text: 'Green',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'Grocer',
                            style: TextStyle(
                                color: CustomColor.customContrasctColor),
                          ),
                        ],
                      ),
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
                //inicio decoração container
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 40.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(45.0),
                  ),
                ),
                //fim decoração container
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //Email
                    const CustomFormField(
                      inputType: TextInputType.emailAddress,
                      label: 'Email',
                      hint: 'fulano@email.com',
                      icon: Icon(Icons.email_outlined), //prefixx
                    ),

                    //Senha
                    const CustomFormField(
                      inputType: TextInputType.text,
                      label: 'Senha',
                      hint: 'Senha forte',
                      icon: Icon(Icons.lock_outline), //prefixx
                      isSecret: true,
                    ),

                    //Botão Entrar
                    SizedBox(
                      height: 50.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            )),
                        onPressed: () {
                          //logica de token
                          Get.toNamed('/base');
                        },
                        child: const Text(
                          'Entrar',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                      ),
                    ),

                    //Botão Esqueci a Senha
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Esqueci a senha',
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

                    //Botão Criar Conta
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 3,
                            side: BorderSide(
                                width: 2, color: CustomColor.customSwatchColor),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )),
                        onPressed: () {
                          Get.toNamed('/cadastro');
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
            ],
          ),
        ),
      ),
    );
  }
}
