
import 'package:cofredesenha/models/password/BankModel.dart';
import 'package:cofredesenha/src/home.dart';
import 'package:cofredesenha/src/home/viewPassword.dart';
import 'package:cofredesenha/src/password/edit/editBank.dart';
import 'package:cofredesenha/utils/screenUtils.dart';
import 'package:cofredesenha/utils/styles.dart';
import 'package:cofredesenha/utils/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';

class PasswordBank extends StatefulWidget {
  String? bank;
  String? agency;
  String? accaunt;
  String? password;
  int? id;
  BankModel? model;
  PasswordBank({Key? key,this.bank, this.agency, this.accaunt, this.password, this.id, this.model}) : super(key: key);

  @override
  _PasswordBank createState() => _PasswordBank();
}

class _PasswordBank extends State<PasswordBank> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: DefaultColors.secondaryColor,
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => EditBank(bank:widget.bank ,password: widget.password,agency: widget.agency, accaunt: widget.accaunt,id: widget.id,model: widget.model,)));},
        child: Icon(Icons.edit,color: Colors.white,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        backgroundColor: DefaultColors.secondaryColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Bancárias",
            style: DefaultStyle.textStyle(
                size: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.symmetric(horizontal: 15),child: formBill(),),
              ],
            )
        ),
      ),
    );
  }
  formBill() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          elevation: 10,
          child: Padding(padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.monetization_on_outlined,
                      color: DefaultColors.secondaryColor,
                    ),
                    SizedBox(width: 10,),
                    Text("Banco: ${widget.bank!}",
                      overflow: TextOverflow.ellipsis,
                      style: DefaultStyle.textStyle(
                        color: DefaultColors.secondaryColor,
                        fontWeight: FontWeight.w700,
                        size: 18
                    ),),
                  ],

                ),
                IconButton(onPressed: (){_copyBank();}, icon: Icon(Icons.copy)),
              ],
            ),
          ),
        ),
        SizedBox(height: 24,),
        Card(
          elevation: 10,
          child: Padding(padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Icon(
                    Icons.emoji_objects_sharp,
                    color: DefaultColors.secondaryColor,
                  ),
                  SizedBox(width: 10,),
                  Text("Agência: ${widget.agency!}",
                    overflow: TextOverflow.ellipsis,
                    style: DefaultStyle.textStyle(
                      color: DefaultColors.secondaryColor,
                      fontWeight: FontWeight.w700,
                      size: 18
                  ),),
                ],),
                IconButton(onPressed: (){_copyAgency();}, icon: Icon(Icons.copy)),

              ],

            )

            ,),
        ),
        SizedBox(height: 24,),
        Card(
          elevation: 10,
          child: Padding(padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Icon(
                    Icons.emoji_objects_sharp,
                    color: DefaultColors.secondaryColor,
                  ),
                  SizedBox(width: 10,),
                  Text("Conta: ${widget.accaunt!}",
                    overflow: TextOverflow.ellipsis,
                    style: DefaultStyle.textStyle(
                      color: DefaultColors.secondaryColor,
                      fontWeight: FontWeight.w700,
                      size: 18
                  ),),
                ],),
                IconButton(onPressed: (){_copyAccaunt();}, icon: Icon(Icons.copy)),

              ],
            )
            ,),
        ),
        SizedBox(height: 24,),
        Card(
          elevation: 10,
          child: Padding(padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                    children:[
                      Icon(
                        Icons.password,
                        color: DefaultColors.secondaryColor,
                      ),
                      SizedBox(width: 10,),
                      Text("Senha: ${widget.password!}",
                        overflow: TextOverflow.ellipsis,
                        style: DefaultStyle.textStyle(
                          color: DefaultColors.secondaryColor,
                          fontWeight: FontWeight.w700,
                          size: 18
                      ),),
                    ]),
                IconButton(onPressed: (){_copy();}, icon: Icon(Icons.copy)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _copy(){
    FlutterClipboard.copy(widget.password!).then(( value ) =>
        print('copied'));
    DefaultScreenUtils.onMessage(context: context, message: "Senha copiada para sua Área de transferência!", isError: false);
  }
  _copyBank(){
    FlutterClipboard.copy(widget.bank!).then(( value ) =>
        print('copied'));
    DefaultScreenUtils.onMessage(context: context, message: "Senha copiada para sua Área de transferência!", isError: false);
  }
  _copyAgency(){
    FlutterClipboard.copy(widget.agency!).then(( value ) =>
        print('copied'));
    DefaultScreenUtils.onMessage(context: context, message: "Senha copiada para sua Área de transferência!", isError: false);
  }
  _copyAccaunt(){
    FlutterClipboard.copy(widget.accaunt!).then(( value ) =>
        print('copied'));
    DefaultScreenUtils.onMessage(context: context, message: "Senha copiada para sua Área de transferência!", isError: false);
  }

}