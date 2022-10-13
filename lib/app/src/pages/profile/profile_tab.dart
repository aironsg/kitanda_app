import 'package:flutter/material.dart';
import 'package:kitanda_app/app/src/config/custom_color.dart';
import 'package:kitanda_app/app/src/pages/common_widgets/custom_form_field.dart';
import 'package:kitanda_app/app/src/config/app_data.dart' as app_data;

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.logout_rounded,
                color: Colors.white,
              )),
        ],
        title: const Text(
          'Perfil do usúario',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          //name
          CustomFormField(
            readOnly: true,
            initialValue: app_data.user.name,
            inputType: TextInputType.text,
            label: 'name',
            hint: '',
            icon: const Icon(Icons.person),
          ),
          //Email
          CustomFormField(
            readOnly: true,
            initialValue: app_data.user.email,
            inputType: TextInputType.emailAddress,
            label: 'Email',
            hint: '',
            icon: const Icon(Icons.email_outlined),
          ),

          //phone
          CustomFormField(
            readOnly: true,
            initialValue: app_data.user.phone,
            inputType: TextInputType.phone,
            label: 'phone',
            hint: '',
            icon: const Icon(Icons.phone),
          ),

          //CPF
          CustomFormField(
            readOnly: true,
            initialValue: app_data.user.cpf,
            inputType: TextInputType.number,
            label: 'CPF',
            hint: '',
            icon: const Icon(Icons.file_copy_outlined),
            isSecret: true,
          ),

          //Botão Atualizar
          SizedBox(
            height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side:
                    BorderSide(color: CustomColor.customSwatchColor, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              onPressed: () async {
                updatePassword();
              },
              child: const Text(
                'Atualizar senha',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<bool?> updatePassword() {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        //Titulo Dialog
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          child: Text(
                            'Atualização de senha',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        //Senha atual
                        const CustomFormField(
                          inputType: TextInputType.text,
                          label: 'Senha Atual',
                          hint: '',
                          icon: Icon(Icons.lock),
                          isSecret: true,
                        ),
                        //Nova senha
                        const CustomFormField(
                          inputType: TextInputType.text,
                          label: 'Nova Senha',
                          hint: '',
                          icon: Icon(Icons.lock_outline),
                          isSecret: true,
                        ),

                        //Repetição de nova senha
                        const CustomFormField(
                          inputType: TextInputType.text,
                          label: 'Repetir Senha',
                          hint: '',
                          icon: Icon(Icons.lock_outline),
                          isSecret: true,
                        ),

                        //Botão de atualização
                        SizedBox(
                          height: 40,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              onPressed: () {},
                              child: const Text(
                                'Atualizar',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
