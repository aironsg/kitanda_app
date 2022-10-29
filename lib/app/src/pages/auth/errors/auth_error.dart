abstract class AuthError {
  static String messageError(String? message) {
    switch (message) {
      case 'INVALID_CREDENTIALS':
        return 'Email e/ou Senha inválidos';

      case 'Invalid session token':
        return 'Falha de Autenticação \n Faça Novamente o Login';
      default:
        return 'Ocorreu um erro Desconhecido!';
    }
  }
}
