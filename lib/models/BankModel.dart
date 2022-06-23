import 'package:cofredesenha/models/cliente.dart';

class BankModel {
  int? id;
  String? bank;
  String? agency;
  String? account;
  String? password;
  String? type;
  Cliente? cliente;

  BankModel(
      {this.bank,
        this.agency,
        this.account,
        this.password,
        this.type,
        this.cliente,
      });

  BankModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bank = json['bank'];
    agency = json['agencyAccount'];
    account = json['account'];
    password = json['bankpassword'];
    type = json['type'];
    cliente = json['cliente'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bank'] = this.bank;
    data['agencyAccount'] = this.agency;
    data['account'] = this.account;
    data['bankpassword'] = this.password;
    data['type'] = this.type;
    data['cliente'] = this.cliente;
    return data;
  }
}
