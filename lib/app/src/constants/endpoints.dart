const String baseUrl = 'https://parseapi.back4app.com/functions/';

abstract class EndPoints {
  static const String signIn = '$baseUrl/login';
  static const String signup = '$baseUrl/signup';
  static const String validateToken = '$baseUrl/validate-token';
  static const String resetPassword = '$baseUrl/reset-password';
  static const String getAllCatogories = '$baseUrl/get-category-list';
  static const String getAllProducts = '$baseUrl/get-product-list';
}
