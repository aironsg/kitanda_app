import 'package:flutter/material.dart';
import 'package:kitanda_app/app/src/config/custom_color.dart';
import 'package:kitanda_app/app/src/pages/common_widgets/custom_form_field.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Email
            const CustomFormField(
              inputType: TextInputType.emailAddress,
              label: 'Email',
              hint: 'Fulano@email.com',
              icon: Icon(Icons.email_outlined),
            ),

            //Nome
            const CustomFormField(
              inputType: TextInputType.text,
              label: 'Nome',
              hint: 'Fulano',
              icon: Icon(Icons.person),
            ),

            //Celular
            const CustomFormField(
              inputType: TextInputType.phone,
              label: 'Celular',
              hint: '(00)0000-0000',
              icon: Icon(Icons.phone),
            ),

            //CPF
            const CustomFormField(
              inputType: TextInputType.number,
              label: 'CPF',
              hint: '000.000.000-00',
              icon: Icon(Icons.file_copy_outlined),
              isSecret: true,
            ),

            //Botão Atualizar
            SizedBox(
              height: 50,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: CustomColor.customSwatchColor, width: 2),
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Atualizar Senha',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
