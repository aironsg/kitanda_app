abstract class AuthError {
  static String messageError(String? message) {
    switch (message) {
      case 'INVALID_CREDENTIALS':
        return 'Email e/ou Senha inválidos';

      default:
        return 'Ocorreu um erro Desconhecido!';
    }
  }
}
