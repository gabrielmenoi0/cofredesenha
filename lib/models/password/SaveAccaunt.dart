import 'package:cofredesenha/models/cliente.dart';

class SaveAccountModel {
  int? id;
  String? local;
  String? password;
  String? observation;
  // Cliente? cliente;


  SaveAccountModel(
      {this.id,
        this.local,
        this.password,
        this.observation,
        // this.cliente,
      });

  SaveAccountModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    local = json['local'];
    password = json['password'];
    observation = json['observation'];
    // cliente = json['cliente'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['local'] = this.local;
    data['password'] = this.password;
    data['observation'] = this.observation;
    // data['cliente'] = this.cliente;
    return data;
  }
}
