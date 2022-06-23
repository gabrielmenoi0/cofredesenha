import 'package:cofredesenha/src/home.dart';
import 'package:cofredesenha/src/home/passwordGenerator.dart';
import 'package:cofredesenha/utils/button.dart';
import 'package:cofredesenha/utils/screenUtils.dart';
import 'package:cofredesenha/utils/styles.dart';
import 'package:cofredesenha/utils/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


class PasswordGenerator3 extends StatefulWidget {

  @override
  _PasswordGenerator3State createState() => _PasswordGenerator3State();
}

class _PasswordGenerator3State extends State<PasswordGenerator3> {
  TextEditingController _controllerTamanho = TextEditingController(text: "8");

  String senha = "";
  var mask = MaskTextInputFormatter(mask: "##");
  bool letrasMaiusculas = true;
  bool letrasMinusculas = true;
  bool numeros = true;
  bool simbolos = true;

  senhaGerada(bool letrasMai, bool letrasMin, bool numeros, bool simbolos) {

    if(letrasMai == false && letrasMin == false && numeros == false && simbolos == false) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(

              content: Text("Para gerar senha é necessário que pelo menos uma opção esteja selecionada!.",style: TextStyle(color: DefaultColors.darkColor2,fontSize: 18, fontWeight: FontWeight.bold),),
              actions: <Widget>[
                DefaultButton(context: context, title: "Fechar",callback: ()=> Navigator.pop(context),)
              ],

            );
          }
      );
    }
    else if(int.parse(_controllerTamanho.text) <= 0){
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(

              content: Text("Para gerar senha é necessário que o tamanho seja maior que 0!.",style: TextStyle(color: DefaultColors.darkColor2,fontSize: 18, fontWeight: FontWeight.bold),),
              actions: <Widget>[
                DefaultButton(context: context, title: "Fechar",callback: ()=> Navigator.pop(context),)
              ],

            );
          }
      );
    }
    else if(int.parse(_controllerTamanho.text) <= 0 && letrasMai == false && letrasMin == false && numeros == false && simbolos == false){
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(

              content: Text("Para gerar senha é necessário que pelo menos uma opção esteja selecionada e o tamanho seja maior que 0!",style: TextStyle(color: DefaultColors.darkColor2,fontSize: 18, fontWeight: FontWeight.bold),),
              actions: <Widget>[
                DefaultButton(context: context, title: "Fechar",callback: ()=> Navigator.pop(context),)
              ],

            );
          }
      );
    }
    else {

      String letrasMaiusculas = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
      String letrasMinusculas = "abcdefghijklmnopqrstuvwxyz";
      String numbers = "0123456789";
      String symbolos = "!@#\$%&*(){}[]-_=+<>,./";

      int tam = int.parse(_controllerTamanho.text);

      String senhaGer = "";
      senhaGer += (letrasMai ? letrasMaiusculas : "");
      senhaGer += (letrasMin ? letrasMinusculas : "");
      senhaGer += (numeros ? numbers : "");
      senhaGer += (simbolos ? symbolos : "");

      String pass = "";

      for(int i = 0; i < tam; i++) {
        int random = Random.secure().nextInt(senhaGer.length);
        pass += senhaGer[random];
        setState(() {
          senha = pass;
        });
      }

      return senha;

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      bottomNavigationBar: DefaultButton(
          callback: ()=> _close(),
          context: context, title: "Usar senha",
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20)),
      body: _body(),
    );
  }
  _close(){
    print(senha);
    senha != " "?
    Navigator.of(context).pop(senha): ScaffoldMessenger.of(context).showSnackBar(empty);
  }
  final empty = SnackBar(
    content: Text(
      "Gere uma senha!",style: DefaultStyle.textStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        size: 14
    ),
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.red,
  );
  _botaoGerarSenha() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DefaultButton(
            callback: ()=> senhaGerada(
              letrasMaiusculas,
              letrasMinusculas,
              numeros,
              simbolos,
            ),
            context: context, title: "Gerar senha",
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20))
      ],
    );

  }

  _body() {
    return Card(
      margin: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text("Gerador de senhas", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),

            Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xfffff),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Tamanho"),
                        Container(
                          width: MediaQuery.of(context).size.width / 6,
                          child: TextField(
                            inputFormatters: [mask],
                            controller: _controllerTamanho,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Letras maiúsculas"),
                        Checkbox(
                          value: letrasMaiusculas,
                          checkColor: Colors.white,
                          activeColor: DefaultColors.secondaryColor,
                          onChanged: (value) {
                            setState(() {
                              letrasMaiusculas = value!;
                            });
                          },
                        )
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Letras minúsculas"),
                        Checkbox(
                          value: letrasMinusculas,
                          checkColor: Colors.white,
                          activeColor: DefaultColors.secondaryColor,
                          onChanged: (value) {
                            setState(() {
                              letrasMinusculas = value!;
                            });
                          },
                        )
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Números"),
                        Checkbox(
                          value: numeros,
                          checkColor: Colors.white,
                          activeColor: DefaultColors.secondaryColor,
                          onChanged: (value) {
                            setState(() {
                              numeros = value!;
                            });
                          },
                        )
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Símbolos"),
                        Checkbox(
                          value: simbolos,
                          checkColor: Colors.white,
                          activeColor: DefaultColors.secondaryColor,
                          onChanged: (value) {
                            setState(() {
                              simbolos = value!;
                            });
                          },
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * .70,
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Center(
                            child: Text(
                              "$senha",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 50,),
                        Container(
                          height: 60,
                          color: DefaultColors.primaryColor,
                          child: TextButton(
                            // color: DefaultColors.secondaryColor,
                            // padding: EdgeInsets.all(5),
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.content_copy, color: Colors.white,),
                                Text("Copiar", style: TextStyle(color: Colors.white),)
                              ],
                            ),
                            onPressed: (){
                              Clipboard.setData(ClipboardData(text: senha));
                              senha.isNotEmpty ? DefaultScreenUtils.onMessage(context: context, message: "Senha copiada para sua Área de transferência!\n", isError: false): "";

                              // _showInfoFlushbarHelper(context);
                            },
                          ),
                        )


                      ],
                    ),
                  ],
                )
            ),
            _botaoGerarSenha(),
          ],
        ),
      ),
    );
  }

  _appBar() {
    return AppBar(
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
          onPressed: (){
            // Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home()));

          }
      ),
      title: Text("Gerador de senhas", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      centerTitle: true,
      backgroundColor: DefaultColors.secondaryColor,
      elevation: 0,
    );
  }



// _showInfoFlushbarHelper(BuildContext context) {
//   FlushbarHelper.createInformation(
//     title: 'Senha copiada',
//     message: 'Agora é só colar onde você quiser!',
//   ).show(context);
// }

}