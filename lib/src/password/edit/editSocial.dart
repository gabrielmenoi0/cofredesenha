import 'package:cofredesenha/data/database.dart';
import 'package:cofredesenha/models/cliente.dart';
import 'package:cofredesenha/models/passwordModel.dart';
import 'package:cofredesenha/models/password/socialModel.dart';
import 'package:cofredesenha/src/home.dart';
import 'package:cofredesenha/src/home/passwordGenerator2.dart';
import 'package:cofredesenha/src/home/passwordGenerator3.dart';
import 'package:cofredesenha/utils/button.dart';
import 'package:cofredesenha/utils/screenUtils.dart';
import 'package:cofredesenha/utils/styles.dart';
import 'package:cofredesenha/utils/textStyle.dart';
import 'package:flutter/material.dart';

class EditSocial extends StatefulWidget {
  String? nome;
  String? password;
  String? type;
  String? ob;
  int? id;
  SocialModel? model;


  EditSocial({Key? key, this.nome, this.password,this.ob, this.id, this.type, this.model}) : super(key: key);

  @override
  _EditSocial createState() => _EditSocial();
}

class _EditSocial extends State<EditSocial> {

  @override
  void initState() {
    nameController.text = widget.nome!;
    passwordController.text = widget.password!;
    usernamecontroller.text = widget.type!;
    // observationController.text = widget.ob!;
    save.id = widget.id!;
    getProfile();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  String result = " ";
  final DatabaseProvider _dbHelper = DatabaseProvider.db;
  String data = "";
  List<Passwords> info = [];
  final _formKey = GlobalKey<FormState>();
  SocialModel save = SocialModel();
  Cliente client = Cliente();
  Cliente? cliente;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController observationController = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
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
                  DefaultButton(context: context, title: "Clique aqui para gerar uma senha",callback:  _generate )
                ],
              ),
            )
        ),
      ),
    );
  }
  _generate() async {
    result = await  Navigator.push(
        context, MaterialPageRoute(builder: (context) => PasswordGenerator3()));
    passwordController.text = result;
    setState(() {

    });
  }
    callbottomSocial(SocialModel item){
    return bottomExludeSocial(context, item);
  }
  getProfile() async{

    cliente = await _dbHelper.getCustomer();
    return cliente;
  }
  exludeSocial(SocialModel item) async {

    var auth = await _dbHelper.deleteSocial(item);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
    
    setState(() {

    });
  }
   bottomExludeSocial(BuildContext context,SocialModel item) {
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
            save.name = nameController.text;
          },
          controller: nameController,
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
      // save.type = "Default";
      print(save.toJson());
      save.id = save.id;
      // save.cliente = null;
      var auth = await _dbHelper.editSocial(save);

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
