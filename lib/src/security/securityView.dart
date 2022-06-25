import 'dart:convert';
import 'package:cofredesenha/data/database.dart';
import 'package:cofredesenha/localAuthService.dart';
import 'package:cofredesenha/utils/styles.dart';
import 'package:cofredesenha/utils/textStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';


class SecurityView extends StatefulWidget {
  @override
  _SecurityView createState() => _SecurityView();
}

class _SecurityView extends State<SecurityView> {

  bool? _checked;
  final DatabaseProvider _dbHelper = DatabaseProvider.db;
  bool? biometric;
  @override
  void initState() {
    getinfo();
    getBiometric();
    // a == null || a.toString().split("authSecurity:").last.split("}").first == " 0"? _checked = false: _checked = true;
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }
  getinfo() async{
    // var a = await _dbHelper.getSecurity();
    // _checked = json.decode(a)["authSecurity"] == "1";
    String? a = await _dbHelper.getSecurity();
    if (a == null) _checked = false;
    _checked = a.toString().split("authSecurity:").last.split("}").first == " 1";
    print("check:${_checked}");
    // _checked = a.toString().split("authSecurity:").last.split("}").first == " 1";
    setState((){});

  }
  getBiometric() async{

    final auth = LocalAuthService(
      auth: LocalAuthentication(),
    );
    final isLocalAuthAvailable = await auth.isBiometricAvailable();
    biometric = isLocalAuthAvailable;
    setState(() {});
    print(biometric);
    if (!mounted) return;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DefaultColors.secondaryColor,
        title: Text(
          "Segurança",
          style: DefaultStyle.textStyle(
              color: Colors.white,
              size: 20,
              fontWeight: FontWeight.w500
          ),
        ),
      ),
      body: _body(),
      backgroundColor: Colors.white,
    );
  }

  _body(){
    if(biometric == null) return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
          color: DefaultColors.secondaryColor,
        ),
          Text(
            "Verificando informações de Segurança do Dispositivo...",
            style: DefaultStyle.textStyle(
                color: DefaultColors.darkColor2,
                size: 18,
                fontWeight: FontWeight.w400
            ),
          )
        ],
      ),
    );
    return SingleChildScrollView(
      child: _mensage(),
    );
  }
  _mensage(){
    // biometric == null ?setState(() {
    // }): setState(() {
    // });
    // return biometric == null?Container():
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Visibility(
          visible: !biometric!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Seu dispositivo não possui senhas ou Biometria cadastrada!",
                    style: DefaultStyle.textStyle(
                        color: DefaultColors.darkColor2,
                        size: 20,
                        fontWeight: FontWeight.w400
                    ),
                  )
              )
              ,
            ],
          ),
        ),
        Visibility(
          visible: biometric!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SwitchListTile(
                title: Text(
                  "Acesso ao app",
                  style: DefaultStyle.textStyle(
                      color: DefaultColors.darkColor2,
                      size: 20,
                      fontWeight: FontWeight.w400
                  ),
                ),
                value: _checked ?? false,
                activeColor: DefaultColors.secondaryColor,
                inactiveThumbColor: DefaultColors.darkColor2,
                inactiveTrackColor: DefaultColors.darkColor2,
                onChanged: (bool value) async{
                  setState(() {
                    _checked = value;
                  });
                  await _dbHelper.saveSecurity(value == true ? "1":"0");


                },
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Solicitar a biometria para acessar o app",
                  style: DefaultStyle.textStyle(
                      color: DefaultColors.darkColor2,
                      size: 16,
                      fontWeight: FontWeight.w400
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );

  }
}

