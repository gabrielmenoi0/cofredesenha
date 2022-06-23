import 'package:cofredesenha/models/cliente.dart';

class SocialModel {
  int? id;
  String? name;
  String? password;
  String? type;
  String? ob;
  // Cliente? cliente;

  SocialModel(
      {this.id,
        this.name,
        this.password,
        this.type,
        this.ob,
        // this.cliente,
      });

  SocialModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    password = json['passwordSocial'];
    type = json['type'];
    // cliente= json['cliente'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['passwordSocial'] = this.password;
    data['type'] = this.type;
    // data['cliente'] = this.cliente;
    return data;
  }
}
