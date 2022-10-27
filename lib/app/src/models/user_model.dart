// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'part_of_models/user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? id;
  /* quando se tem um nome padrão na API, e você não quer mudar na classe
  rodar o comando flutter pub run build_runner build, para reconstruir o fromJson e ToJson */
  @JsonKey(name: 'fullname')
  String? name;
  String? email;
  String? phone;
  String? cpf;
  String? password;
  String? token;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.cpf,
      this.password,
      this.token});

  //desta forma funciona
  //continuar com este, devido a aula
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        id: map['id'],
        name: map['fullname'],
        email: map['email'],
        password: map['password'],
        phone: map['phone'],
        cpf: map['cpf'],
        token: map['token']);
  }

  //forma 2 para o toMap

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullname': name,
      'email': email,
      'password': password,
      'phone': phone,
      'cpf': cpf,
      'token': token
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, phone: $phone, cpf: $cpf, password: $password, token: $token)';
  }
}



//estes modelos é apenas comparação


//desta forma tambem
  /*
  UserModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name= map['fullname'];
    email= map['email'];
    phone= map['phone'];
    cpf= map['cpf'];
    token= map['token'];
  }*/

  /*
  forma 1 totalmente utilizavel para o toMap

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['fullname'] = name;
    map['email'] = email;
    map['password'] = password;
    map['phone'] = phone;
    map['cpf'] = cpf;
    map['token'] = token;

    return map;
  }

  */