import 'package:kitanda_app/app/src/constants/endpoints.dart';
import 'package:kitanda_app/app/src/models/user_model.dart';
import 'package:kitanda_app/app/src/pages/auth/result/auth_result.dart';
import 'package:kitanda_app/app/src/services/http_magager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  AuthResult handleUserOuError(Map<dynamic, dynamic> result) {
    if (result['result'] != null) {
      final user = UserModel.fromJson(result['result']);
      return AuthResult.success(user);
    } else {
      return AuthResult.error(result['error']);
    }
  }

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

    return handleUserOuError(result);
  }

  //validação token
  Future<AuthResult> validateToken(String token) async {
    final result = await _httpManager.restRequest(
      url: EndPoints.validateToken,
      method: HttpMethod.post,
      hearders: {'X-Parse-Session-Token': token},
    );

    return handleUserOuError(result);
  }

  Future<AuthResult> signUp(UserModel user) async {
    final result = await _httpManager.restRequest(
      url: EndPoints.signup,
      method: HttpMethod.post,
      body: user.toJson(),
    );

    return handleUserOuError(result);
  }

  Future<void> resetPassword(String email) async {
    await _httpManager.restRequest(
      url: EndPoints.resetPassword,
      method: HttpMethod.post,
      body: {'email': email},
    );
  }
}
