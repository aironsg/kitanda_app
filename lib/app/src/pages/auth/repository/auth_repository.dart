import 'package:kitanda_app/app/src/constants/endpoints.dart';
import 'package:kitanda_app/app/src/services/http_magager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  //Autenticação
  Future signIn({required String email, required String password}) async {
    var result = await _httpManager.restRequest(
      url: EndPoints.signIn,
      method: HttpMethod.post,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (result['result'] != null) {
      //faça alguma coisa
      print('authentication sucess');
      print(result['result']);
    } else {
      //faça outra coisa
      print('failure');
      print(result['error']);
    }
  }

  //Cadastro

  Future signUp(
      {required String email,
      required String password,
      required String fullname,
      required String phone,
      required String cpf}) async {
    var result = await _httpManager.restRequest(
      url: EndPoints.signup,
      method: HttpMethod.post,
      body: {
        "email": email,
        "password": password,
        "fullname": fullname,
        "phone": phone,
        "cpf": cpf,
      },
    );
  }
}
