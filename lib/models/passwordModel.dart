import 'package:cofredesenha/models/cliente.dart';

class Passwords {
  int? id;
  String? local;
  String? senha;
  String? observation;
  Cliente? cliente;

  Passwords({this.local, this.senha, this.observation});

  Passwords.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    local = json['local'];
    senha = json['senha'];
    observation = json['observation'];
    cliente = json['cliente'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['local'] = this.local;
    data['senha'] = this.senha;
    data['observation'] = this.observation;
    data['cliente'] = this.cliente;
    return data;
  }
}