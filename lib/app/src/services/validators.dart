import 'package:get/get.dart';

String? emailValidator(String? email) {
  if (email == null || email.isEmpty) return 'Digite seu email';

  if (!email.isEmail) return 'Digite um email valido!';

  return null;
}

String? passwordValidator(String? password) {
  if (password == null || password.isEmpty) return 'Digite sua senha';

  if (password.length <= 7) return 'Senha incompativel, minino de 8 caracteres';

  return null;
}

String? nameValidator(String? name) {
  if (name == null || name.isEmpty) return 'Digite Seu Nome';

  final names = name.split(' ');

  if (names.length == 1) return 'Informe seu nome Completo';

  return null;
}

String? phoneValidator(String? phone) {
  if (phone == null || phone.isEmpty) return 'Digite seu Celular';

  if (phone.length < 15 || !phone.isPhoneNumber) {
    return 'Informe um Celular válido!';
  }
  return null;
}

String? cpfValidator(String? cpf) {
  if (cpf == null || cpf.isEmpty) return 'Digite seu CPF';

  if (!cpf.isCpf) return 'Informe um CPF válido';

  return null;
}
