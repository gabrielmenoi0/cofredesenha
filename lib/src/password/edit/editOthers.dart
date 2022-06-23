import 'package:cofredesenha/data/database.dart';
import 'package:cofredesenha/models/password/SaveAccaunt.dart';
import 'package:cofredesenha/models/passwordModel.dart';
import 'package:cofredesenha/src/home.dart';
import 'package:cofredesenha/src/home/passwordGenerator.dart';
import 'package:cofredesenha/src/home/passwordGenerator3.dart';
import 'package:cofredesenha/src/home/viewPassword.dart';
import 'package:cofredesenha/utils/button.dart';
import 'package:cofredesenha/utils/screenUtils.dart';
import 'package:cofredesenha/utils/styles.dart';
import 'package:cofredesenha/utils/textStyle.dart';
import 'package:flutter/material.dart';

class EditPassword extends StatefulWidget {
  String? local;
  String? pass;
  String? ob;
  int? id;
  SaveAccountModel? model;


  EditPassword({Key? key, this.local, this.pass,this.ob, this.id, this.model}) : super(key: key);

  @override
  _EditPassword createState() => _EditPassword();
}

class _EditPassword extends State<EditPassword> {

  @override
  void initState() {
    localController.text = widget.local!;
    passwordController.text = widget.pass!;
    observationController.text = widget.ob!;
    save.id = widget.id!;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  final DatabaseProvider _dbHelper = DatabaseProvider.db;
  String data = "";
  String result = " ";
  List<Passwords> info = [];
  final _formKey = GlobalKey<FormState>();
  SaveAccountModel save = SaveAccountModel();
  TextEditingController localController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController observationController = TextEditingController();
  bool _showPassword = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _button(),
      appBar: AppBar(
        backgroundColor: DefaultColors.secondaryColor,
        actions: [IconButton(onPressed: (){callbottomSocial(widget.model!);}, icon: Icon(Icons.delete_outline_outlined,size: 30,color: Colors.white,)),],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
          onPressed: (){
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));

          }
        ),
        title: Text("Edite sua Conta",
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
                  Padding(padding: EdgeInsets.symmetric(horizontal: 15),child: formBill(),),
                  SizedBox(
                    height: 20,
                    // child: PasswordGenerator(),
                  ),
                  DefaultButton(context: context, title: "Clique aqui para gerar uma senha",callback: _generate)
                ],
              ),
            ),
        ),
      ),
    );
  }
  callbottomSocial(SaveAccountModel item){
    return bottomExludeSocial(context, item);
  }
  exludeSocial(SaveAccountModel item) async {

    var auth = await _dbHelper.deleteAccount(item);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));

    setState(() {

    });
  }
  bottomExludeSocial(BuildContext context,SaveAccountModel item) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isDismissible: false,
        enableDrag: false,
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (context, setState) {
            return Wrap(
              children: [
                Container(
                  decoration: decorationBottom(),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        closeBottom(context),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Atenção!",
                              style: DefaultStyle.textStyle(
                                  size: 24,
                                  fontWeight: FontWeight.w700,
                                  color: DefaultColors.secondaryColor),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Tem certeza que deseja excluir essa conta?",
                          style: DefaultStyle.textStyle(
                              size: 20,
                              fontWeight: FontWeight.w400,
                              color: DefaultColors.darkColor1),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                child: DefaultButton(
                                  context: context,
                                  title: "Sim",
                                ),
                                onTap: () => exludeSocial(item),
                              ),

                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: DefaultButton(
                                fillColor: DefaultColors.secondaryColor,
                                context: context,
                                title: "Não",
                                callback: () => Navigator.pop(context),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          });
        });
  }
  static Widget closeBottom(BuildContext context,
      {Color? iconColor = Colors.grey}) =>
      Container(
        alignment: Alignment.centerRight,
        child: IconButton(
            icon: Icon(
              Icons.clear,
              color: iconColor,
            ),
            onPressed: () => Navigator.pop(context)),
      );

  static BoxDecoration decorationBottom() =>
      const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14), topRight: Radius.circular(14)));

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
        SizedBox(
          height: 24,
        ),
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
        // SizedBox(
        //   height: 24,
        // ),
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
          obscureText: _showPassword == false ? true : false,
          decoration: InputDecoration(
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
          height: 120,
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
                        // validator: (String? name) {
                        //   if (name!.isEmpty) {
                        //     return "Campo obrigatório";
                        //   }
                        // },
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
  _generate() async {
    result = await  Navigator.push(
        context, MaterialPageRoute(builder: (context) => PasswordGenerator3()));
    passwordController.text = result;
    setState(() {

    });
  }
  _button() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: DefaultButton(
        context: context,
        title: "Alterar",
        callback: go,
      ),
    );
  }

  go() async{
    try{
      String? teste;
      if (!_formKey.currentState!.validate()) return;
      _formKey.currentState!.save();
      save.id = save.id;
      var auth = await _dbHelper.editAccount(save);
      print(save.toJson());
      // Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));

    }catch(e){
      DefaultScreenUtils.onMessage(context: context, message: "Erro ao alterar!", isError: true);
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
