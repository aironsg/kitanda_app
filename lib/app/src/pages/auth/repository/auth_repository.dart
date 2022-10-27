import 'package:kitanda_app/app/src/constants/endpoints.dart';
import 'package:kitanda_app/app/src/models/user_model.dart';
import 'package:kitanda_app/app/src/pages/auth/errors/auth_error.dart';
import 'package:kitanda_app/app/src/pages/auth/result/auth_result.dart';
import 'package:kitanda_app/app/src/services/http_magager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  //Autenticação
  Future<AuthResult> signIn(
      {required String email, required String password}) async {
    var result = await _httpManager.restRequest(
      url: EndPoints.signIn,
      method: HttpMethod.post,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (result['result'] != null) {
      final user = UserModel.fromJson(result['result']);
      return AuthResult.success(user);
    } else {
      return AuthResult.error(AuthError.messageError(result['error']));
    }
  }
}
