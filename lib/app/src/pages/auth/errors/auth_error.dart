abstract class AuthError {
  static String messageError(String? message) {
    switch (message) {
      case 'INVALID_CREDENTIALS':
        return 'Email e/ou Senha inválidos';

      case 'Invalid session token':
        return 'Falha de Autenticação \n Faça Novamente o Login';

      case 'INVALID_FULLNAME':
        return 'Ocorreu um erro ao cadastrar usuário: Nome inválido!';

      case 'INVALID_PHONE':
        return 'Ocorreu um erro ao cadastrar usuário: Celular inválido!';

      case 'INVALID_CPF':
        return 'Ocorreu um erro ao cadastrar usuário: CPF inválido!';

      default:
        return 'Ocorreu um erro Desconhecido!';
    }
  }
}
