class Cliente {

  String? nome;
  String? email;
  String? senha;
  //DATABASE LOCAL
  int? id;

  Cliente(
      {
        this.nome,
        this.email,
        this.senha,
      });

  Cliente.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    email = json['email'];
    id = json['id'];
    senha = json['senha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['id'] = this.id;
    data['senha'] = this.senha;
    return data;
  }
}
