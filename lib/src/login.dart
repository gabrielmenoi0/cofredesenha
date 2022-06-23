import 'package:cofredesenha/data/database.dart';
import 'package:cofredesenha/models/cliente.dart';
import 'package:cofredesenha/models/loginModel.dart';
import 'package:cofredesenha/src/home.dart';
import 'package:cofredesenha/src/tour/tour_view.dart';
import 'package:cofredesenha/utils/button.dart';
import 'package:cofredesenha/utils/images.dart';
import 'package:cofredesenha/utils/screenUtils.dart';
import 'package:cofredesenha/utils/styles.dart';
import 'package:cofredesenha/utils/textStyle.dart';
import 'package:cofredesenha/utils/validations/general.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  void initState() {
    _getCustomer();
    super.initState();
  }
  bool _showPassword = false;
  LoginModel save = LoginModel();
  final _formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final DatabaseProvider _dbHelper = DatabaseProvider.db;
  var mask = MaskTextInputFormatter(mask: "######");


  snackBarError(String error) => SnackBar(
    content: Text(
      "Verifique sua conexão de Internet.",
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.red,
  );

    Cliente? result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            //padding: EdgeInsets.only(bottom: 50),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      DefaultAssets.logo,
                      width: MediaQuery.of(context).size.width /3,
                    ),
                  ),
                  SizedBox(
                    height: 10 * 3,
                  ),
                  TextFormField(
                    onSaved: (value){
                      save.email = emailcontroller.text;
                    },
                    controller: emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => Validator.validateEmail(value ?? ""),
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: "email@gmail.com",
                      prefixIcon: Icon(Icons.email_outlined, color: DefaultColors.secondaryColor,),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(color:DefaultColors.secondaryColor)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onSaved: (value){
                      save.senha = passwordcontroller.text;
                    },
                    inputFormatters: [mask],
                    controller: passwordcontroller,
                    validator: (String? cpf) {
                    if (cpf!.isEmpty) {
                    return "Campo obrigatório";
                    }},
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.black,),
                    decoration: InputDecoration(
                      hintText: "Senha",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: DefaultColors.secondaryColor)),
                      prefixIcon: Icon(Icons.key, color: DefaultColors.secondaryColor,),
                      suffixIcon: GestureDetector(
                        child: Icon(
                          _showPassword == false
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: DefaultColors.secondaryColor,
                        ),
                        onTap: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      ),
                    ),
                    obscureText: _showPassword == false ? true : false,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DefaultButton(
                    context: context,
                    title: "Entrar",
                    callback: () => _open(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Não possui uma conta?" ,
                    textAlign: TextAlign.center,
                    style: DefaultStyle.textStyle(
                        size: 15,
                        fontWeight: FontWeight.w700,
                        color: DefaultColors.textColor
                    ),),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: () => _register(),
                    child: Text("Faça seu cadastro agora!", textAlign: TextAlign.center,
                      style: DefaultStyle.textStyle(
                          isUnderlined: true,
                          size: 15,
                          fontWeight: FontWeight.w700,
                          color: DefaultColors.secondaryColor
                      ),),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _register(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Tour()));
  }
  _getCustomer() async {
    result = await _dbHelper.getCustomer();
    // try{
    //   await OneSignalController().configureOneSignal();
    //   await Future.delayed(const Duration(seconds: 2));
    // }
    // catch(e){
    //
    // }
    // await Future.delayed(const Duration(seconds: 5));
    //

    return result;
  }
  _open() async {
    try{
      if (!_formkey.currentState!.validate()) return;
      _formkey.currentState!.save();
      if(result!.email == save.email && result!.senha == save.senha){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
      }else{
        DefaultScreenUtils.onMessage(context: context, message: "Email ou senha Inválida!", isError: true);

      }
    }
    catch(e){
      DefaultScreenUtils.onMessage(context: context, message: "Email ou senha Inválida", isError: true);
    }
  }
}
