import 'package:cofredesenha/data/database.dart';
import 'package:cofredesenha/models/password/SaveAccaunt.dart';
import 'package:cofredesenha/models/passwordModel.dart';
import 'package:cofredesenha/src/home.dart';
import 'package:cofredesenha/utils/button.dart';
import 'package:cofredesenha/utils/screenUtils.dart';
import 'package:cofredesenha/utils/styles.dart';
import 'package:cofredesenha/utils/textStyle.dart';
import 'package:flutter/material.dart';

class AddPassword extends StatefulWidget {
  const AddPassword({Key? key}) : super(key: key);

  @override
  _AddPassword createState() => _AddPassword();
}

class _AddPassword extends State<AddPassword> {

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
  SaveAccountModel save = SaveAccountModel();
  TextEditingController localController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController observationController = TextEditingController();
  TextEditingController userController = TextEditingController();

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
                  Padding(padding: EdgeInsets.symmetric(horizontal: 15),child: formBill()),
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
            save.local = localController.text;
          },
          controller: localController,
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
        // SizedBox(
        //   height: 24,
        // ),
        // TextFormField(
        //   onSaved: (value){
        //     save.username = userController.text;
        //   },
        //   controller: userController,
        //   keyboardType: TextInputType.text,
        //   validator: (String? name) {
        //     if (name!.isEmpty) {
        //       return "Campo obrigatório";
        //     }
        //   },
        //   style: TextStyle(
        //     color: Colors.black,
        //   ),
        //   decoration: InputDecoration(
        //     labelText: "Usuário",
        //     labelStyle: DefaultStyle.textStyle(
        //         size: 20,
        //         color: DefaultColors.darkColor2,
        //         fontWeight: FontWeight.w400),
        //     enabledBorder: UnderlineInputBorder(
        //         borderSide:
        //         BorderSide(color: DefaultColors.secondaryColor)),
        //   ),
        // ),
        SizedBox(
          height: 24,
        ),
        TextFormField(
          onSaved: (value){
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
        SizedBox(
          height: 24,
        ),
        SizedBox(
          height: 150,
          child: Card(
              elevation: 10,
              color: Colors.white, //Color.fromRGBO(241, 241, 243, 1),
              child: Container(
                //height: 200,
                // padding: EdgeInsets.all(10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4)),
                            // color: Color.fromRGBO(241, 241, 243, 1),
                          ),
                          //Color.fromRGBO(241, 241, 243, 1),
                          padding:
                          EdgeInsets.all(10), //Color.fromRGBO(241, 241, 243, 1),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Observações",
                            style: DefaultStyle.textStyle(
                size: 20,
                color: DefaultColors.darkColor2,
                fontWeight: FontWeight.w400),
                          ),
                        ),Padding(padding: EdgeInsets.all(10),child:                         TextFormField(
                          onSaved: (value){
                            save.observation = observationController.text;
                          },
                          controller: observationController,
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
                            // labelText: "Escreva aqui suas observações",
                            // labelStyle: DefaultStyle.textStyle(
                            //     size: 14,
                            //     color: DefaultColors.darkColor2,
                            //     fontWeight: FontWeight.w400),

                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(
                                    color: Colors.white
                                    // color: DefaultColors.secondaryColor
                                ),
                                borderRadius:BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10),topLeft: Radius.circular(10),topRight: Radius.circular(10)) ),
                          ),
                        ),),

                      ])),
            ),
        ),
        
      ],
    );
  }
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
      var auth = await _dbHelper.saveAccount(save);
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
