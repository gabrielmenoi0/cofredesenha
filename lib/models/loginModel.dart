import 'package:cofredesenha/models/cliente.dart';

class LoginModel {
  String? nome;
  String? senha;
  String? email;
  Cliente? cliente;


  LoginModel(
      {this.nome,
        this.senha,
        this.email,
        this.cliente,

      });

  LoginModel.fromJson(Map<String, dynamic> json) {
    nome = json['NOME'];
    senha = json['SENHA'];
    email = json['EMAIL'];
    cliente = json['cliente'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['NOME'] = nome;
    data['SENHA'] = senha;
    data['EMAIL'] = email;
    data['cliente'] = cliente;
    return data;
  }
}