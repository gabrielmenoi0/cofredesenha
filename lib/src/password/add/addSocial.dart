import 'dart:convert';

import 'package:cofredesenha/data/database.dart';
import 'package:cofredesenha/models/passwordModel.dart';
import 'package:cofredesenha/models/password/socialModel.dart';
import 'package:cofredesenha/src/home.dart';
import 'package:cofredesenha/utils/button.dart';
import 'package:cofredesenha/utils/screenUtils.dart';
import 'package:cofredesenha/utils/styles.dart';
import 'package:cofredesenha/utils/textStyle.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class AddSocial extends StatefulWidget {
  const AddSocial({Key? key}) : super(key: key);

  @override
  _AddSocial createState() => _AddSocial();
}

class _AddSocial extends State<AddSocial> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  final DatabaseProvider _dbHelper = DatabaseProvider.db;
  String data = "";
  List<Passwords> info = [];
  final _formKey = GlobalKey<FormState>();
  SocialModel save = SocialModel();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController observationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _button(),
      appBar: AppBar(
        backgroundColor: DefaultColors.secondaryColor,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);

            }
        ),
        title: Text("Adicione seus dados",
            style: DefaultStyle.textStyle(
                size: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.symmetric(horizontal: 15),child: formBill(),)
                ],
              ),
            )
        ),
      ),
    );
  }
  formBill() {
    return Column(
      children: [
        SizedBox(
          height: 24,
        ),
        TextFormField(
          onSaved: (value){
            save.name = namecontroller.text;
          },
          controller: namecontroller,
          keyboardType: TextInputType.text,
          validator: (String? name) {
            if (name!.isEmpty) {
              return "Campo obrigatório";
            }
          },
          style: TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            labelText: "Plataforma",
            labelStyle: DefaultStyle.textStyle(
                size: 20,
                color: DefaultColors.darkColor2,
                fontWeight: FontWeight.w400),
            enabledBorder: UnderlineInputBorder(
                borderSide:
                BorderSide(color: DefaultColors.secondaryColor)),
          ),
        ),
        SizedBox(
          height: 24,
        ),
        TextFormField(
          onSaved: (value){
            save.type = usernamecontroller.text;
          },
          controller: usernamecontroller,
          keyboardType: TextInputType.text,
          // inputFormatters: [mask],
          validator: (String? name) {
            if (name!.isEmpty) {
              return "Campo obrigatório";
            }
          },
          style: TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            labelText: "Usuário",
            labelStyle: DefaultStyle.textStyle(
                size: 20,
                color: DefaultColors.darkColor2,
                fontWeight: FontWeight.w400),
            enabledBorder: UnderlineInputBorder(
                borderSide:
                BorderSide(color: DefaultColors.secondaryColor)),
          ),
        ),
        SizedBox(
          height: 24,
        ),
        TextFormField(
          onSaved: (value){
            // save.password = md5.convert(utf8.encode(value!)).toString();
            save.password = passwordController.text;
          },
          controller: passwordController,
          keyboardType: TextInputType.text,
          // inputFormatters: [mask],
          validator: (String? name) {
            if (name!.isEmpty) {
              return "Campo obrigatório";
            }
          },
          style: TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            labelText: "Senha",
            labelStyle: DefaultStyle.textStyle(
                size: 20,
                color: DefaultColors.darkColor2,
                fontWeight: FontWeight.w400),
            enabledBorder: UnderlineInputBorder(
                borderSide:
                BorderSide(color: DefaultColors.secondaryColor)),
          ),
        ),
        // SizedBox(
        //   height: 24,
        // ),
        // TextFormField(
        //   onSaved: (value){
        //     save.ob = observationController.text;
        //   },
        //   controller: observationController,
        //   keyboardType: TextInputType.text,
        //   // validator: (String? name) {
        //   //   if (name!.isEmpty) {
        //   //     return "Campo obrigatório";
        //   //   }
        //   // },
        //   style: TextStyle(
        //     color: Colors.black,
        //   ),
        //   decoration: InputDecoration(
        //     labelText: "Observação",
        //     labelStyle: DefaultStyle.textStyle(
        //         size: 20,
        //         color: DefaultColors.darkColor2,
        //         fontWeight: FontWeight.w400),
        //     enabledBorder: UnderlineInputBorder(
        //         borderSide:
        //         BorderSide(color: Color.fromRGBO(218, 218, 221, 1))),
        //   ),
        // ),
        SizedBox(
          height: 24,
        ),
      ],
    );
  }
  // String textToMd5(String text) {
  //   return md5.convert(utf8.encode(text)).toString();
  // }
  _button() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: DefaultButton(
        context: context,
        title: "Salvar",
        callback: go,
      ),
    );
  }

  go() async{
    try{
      if (!_formKey.currentState!.validate()) return;
      _formKey.currentState!.save();
      // save.type ="Default";
      var auth = await _dbHelper.saveSocial(save);
      print(save.toJson());
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    }catch(e){
      DefaultScreenUtils.onMessage(context: context, message: "Erro ao salvar!", isError: true);
    }

  }

  emptyRefund() {
    return Column(
      children: [
        // Center(
        //     child: Image.asset(
        //       DefaultAssets.emptyDependents,
        //       height: 250,
        //     )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Nenhuma senha cadastrada!",
              style: DefaultStyle.textStyle(
                  fontWeight: FontWeight.w700,
                  color: DefaultColors.darkColor2,
                  size: 24),
            )
          ],
        ),
      ],
    );
  }
}
