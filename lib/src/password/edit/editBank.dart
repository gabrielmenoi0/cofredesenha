import 'package:cofredesenha/data/database.dart';
import 'package:cofredesenha/models/password/BankModel.dart';
import 'package:cofredesenha/models/passwordModel.dart';
import 'package:cofredesenha/src/home.dart';
import 'package:cofredesenha/src/home/passwordGenerator3.dart';
import 'package:cofredesenha/utils/button.dart';
import 'package:cofredesenha/utils/screenUtils.dart';
import 'package:cofredesenha/utils/styles.dart';
import 'package:cofredesenha/utils/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditBank extends StatefulWidget {
  String? bank;
  String? agency;
  String? accaunt;
  String? password;
  String? type;
  int? id;
  BankModel? model;


  EditBank({Key? key, this.bank, this.agency, this.accaunt, this.password,this.type, this.id, this.model}) : super(key: key);

  @override
  _EditBank createState() => _EditBank();
}

class _EditBank extends State<EditBank> {

  @override
  void initState() {
    BankController.text = widget.bank!;
    passwordController.text = widget.password!;
    AgencyController.text = widget.agency!;
    AccauntController.text = widget.accaunt!;
    save.id = widget.id!;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  String result = "";
  final DatabaseProvider _dbHelper = DatabaseProvider.db;
  String data = "";
  List<Passwords> info = [];
  final _formKey = GlobalKey<FormState>();
  BankModel save = BankModel();
  TextEditingController BankController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController AgencyController = TextEditingController();
  TextEditingController AccauntController = TextEditingController();
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _button(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: DefaultColors.secondaryColor,
        actions: [IconButton(onPressed: (){callbottomBank(widget.model!);}, icon: Icon(Icons.delete_outline_outlined,size: 30,color: Colors.white,)),],
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
        title: Text("Edite seus dados",
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
            )
        ),
      ),
    );
  }
  callbottomBank(BankModel item){
    return bottomExludeBank(context, item);
  }

  exludeBank(BankModel item) async {

    var auth = await _dbHelper.deleteBank(item);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));

    setState(() {

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


  bottomExludeBank(BuildContext context,BankModel item) {
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
                                onTap: () => exludeBank(item),
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
  bottomExlude(BuildContext context,BankModel item) {
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
                                onTap: () => exludeBank(item),
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
  formBill() {
    return Column(
      children: [
        SizedBox(
          height: 24,
        ),
        TextFormField(
          onSaved: (value){
            save.bank = BankController.text;
          },
          controller: BankController,
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
            labelText: "Banco",
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
            save.agency = AgencyController.text;
          },
          controller: AgencyController,
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
            labelText: "Agência",
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
            save.account = AccauntController.text;
          },
          controller: AccauntController,
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
            labelText: "Conta",
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
      save.id = save.id;
      _formKey.currentState!.save();

      var auth = await _dbHelper.editBank(save);
      print(save.toJson());
      // Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));

    }catch(e){
      DefaultScreenUtils.onMessage(context: context, message: "Erro ao alterar!", isError: true);
    }

  }

}
