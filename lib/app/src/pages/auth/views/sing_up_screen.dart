import 'package:flutter/material.dart';
import 'package:kitanda_app/app/src/pages/auth/controller/auth_controller.dart';
import 'package:kitanda_app/app/src/pages/common_widgets/custom_form_field.dart';
import 'package:kitanda_app/app/src/config/custom_color.dart';
import 'package:get/get.dart';
import 'package:kitanda_app/app/src/pages_routers/app_pages.dart';
import 'package:kitanda_app/app/src/services/validators.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  var cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );
  var phoneFormatter = MaskTextInputFormatter(
    mask: '(##)#-####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final _formKey = GlobalKey<FormState>();

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColor.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              //container superior
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //botão de voltar
                        SafeArea(
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.white,
                            ),
                            onPressed: (() {
                              Get.offNamed(PageRoutes.signInRouter);
                            }),
                          ),
                        ),

                        //Texto central
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 60),
                          child: Center(
                            child: Text(
                              'Cadastro',
                              style: TextStyle(
                                  fontSize: 40.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //container inferior

              //Formulario
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 25.0, horizontal: 40.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40.0),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //Email
                      CustomFormField(
                        validator: emailValidator,
                        onSaved: (value) {
                          authController.user.email = value;
                        },
                        inputType: TextInputType.emailAddress,
                        label: 'Email',
                        hint: 'fulano@emai.com',
                        icon: const Icon(Icons.email_outlined),
                      ),

                      //password
                      CustomFormField(
                        validator: passwordValidator,
                        onSaved: (value) {
                          authController.user.password = value;
                        },
                        label: 'password',
                        hint: 'password forte',
                        icon: const Icon(Icons.lock_outline),
                        isSecret: true,
                      ),

                      //name completo
                      CustomFormField(
                        validator: nameValidator,
                        onSaved: (value) {
                          authController.user.name = value;
                        },
                        label: 'name Completo',
                        hint: 'Fulano de tal',
                        icon: const Icon(Icons.person),
                      ),

                      //Telefone
                      CustomFormField(
                        validator: phoneValidator,
                        onSaved: (value) {
                          authController.user.phone = value;
                        },
                        inputType: TextInputType.phone,
                        label: 'phone',
                        hint: '(81)9-9999-9999',
                        icon: const Icon(Icons.phone),
                        inputFormatters: [phoneFormatter],
                      ),

                      //CPF
                      CustomFormField(
                        validator: cpfValidator,
                        onSaved: (value) {
                          authController.user.cpf = value;
                        },
                        inputType: TextInputType.number,
                        label: 'CPF',
                        hint: '000.111.222.33',
                        icon: const Icon(Icons.file_copy),
                        inputFormatters: [cpfFormatter],
                      ),

                      //Botão cadastrar
                      SizedBox(
                        height: 50.0,
                        child: Obx(
                          () => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )),
                            onPressed: authController.isLoading.value
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      authController.signUp();
                                    }
                                  },
                            child: authController.isLoading.value
                                ? const CircularProgressIndicator()
                                : const Text(
                                    'Cadastrar Usúario',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
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
