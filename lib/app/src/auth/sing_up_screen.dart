import 'package:flutter/material.dart';
import 'package:kitanda_app/app/src/auth/components/custom_form_field.dart';
import 'package:kitanda_app/app/src/auth/config/custom_color.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// ignore: must_be_immutable
class SingUpScreen extends StatelessWidget {
  SingUpScreen({Key? key}) : super(key: key);

  var cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );
  var phoneFormatter = MaskTextInputFormatter(
    mask: '(##)#-####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );

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
                              Get.toNamed('/');
                            }),
                          ),
                        ),

                        //Texto central
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 100),
                          child: Center(
                            child: Text(
                              'Cadastro',
                              style: TextStyle(
                                  fontSize: 42.0,
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
                    vertical: 32.0, horizontal: 40.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //Email
                    const CustomFormField(
                      inputType: TextInputType.emailAddress,
                      label: 'Email',
                      hint: 'fulano@emai.com',
                      icon: Icon(Icons.email_outlined),
                    ),

                    //Senha
                    const CustomFormField(
                      inputType: TextInputType.text,
                      label: 'Senha',
                      hint: 'senha forte',
                      icon: Icon(Icons.lock_outline),
                      isSecret: true,
                    ),

                    //Nome completo
                    const CustomFormField(
                      inputType: TextInputType.name,
                      label: 'Nome Completo',
                      hint: 'Fulano de tal',
                      icon: Icon(Icons.person),
                    ),

                    //Telefone
                    CustomFormField(
                      inputType: TextInputType.phone,
                      label: 'Celular',
                      hint: '(81)9-9999-9999',
                      icon: const Icon(Icons.phone),
                      inputFormatters: [phoneFormatter],
                    ),

                    //CPF
                    CustomFormField(
                      inputType: TextInputType.number,
                      label: 'CPF',
                      hint: '000.111.222.33',
                      icon: const Icon(Icons.file_copy),
                      inputFormatters: [cpfFormatter],
                    ),

                    //Botão cadastrar
                    SizedBox(
                      height: 50.0,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )),
                          onPressed: () {},
                          child: const Text(
                            'Cadastrar Usúario',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    )
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
