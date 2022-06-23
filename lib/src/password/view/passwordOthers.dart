import 'package:cofredesenha/models/password/SaveAccaunt.dart';
import 'package:cofredesenha/src/home.dart';
import 'package:cofredesenha/src/home/viewPassword.dart';
import 'package:cofredesenha/src/password/edit/editOthers.dart';
import 'package:cofredesenha/utils/screenUtils.dart';
import 'package:cofredesenha/utils/styles.dart';
import 'package:cofredesenha/utils/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';

class Password extends StatefulWidget {
  String? local;
  String? pass;
  String? ob;
  int? id;
  String? username;
  SaveAccountModel? model;
  Password({Key? key,this.local,this.pass,this.ob, this.id,this.username,this.model}) : super(key: key);

  @override
  _Password createState() => _Password();
}

class _Password extends State<Password> {

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
              MaterialPageRoute(builder: (context) => EditPassword(local: widget.local,pass: widget.pass,
              ob: widget.ob,
              id: widget.id,
                model: widget.model,
              )));},
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
        title: Text("Outras senhas",
            style: DefaultStyle.textStyle(
                size: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.symmetric(horizontal: 15),child: formBill(),)
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
                      Icons.supervisor_account_outlined,
                      color: DefaultColors.secondaryColor,
                    ),
                    SizedBox(width: 10,),
                    Text("Plataforma: ${widget.local!}",
                      overflow: TextOverflow.ellipsis,
                      style: DefaultStyle.textStyle(
                        color: DefaultColors.secondaryColor,
                        fontWeight: FontWeight.w700,
                        size: 18
                    ),),

                  ],

                ),
                IconButton(onPressed: (){_copyPlataform();}, icon: Icon(Icons.copy)),

              ],
            ),
            ),
        ),
       // SizedBox(height: 24,),
       //  Card(
       //    elevation: 10,
       //    child: Padding(padding: EdgeInsets.all(15),
       //      child: Row(
       //        mainAxisAlignment: MainAxisAlignment.spaceBetween,
       //        children: [
       //          Row(
       //            children: [
       //              Icon(
       //                Icons.supervisor_account_outlined,
       //                color: DefaultColors.secondaryColor,
       //              ),
       //              SizedBox(width: 10,),
       //              Text("Usuário: ${widget.username!}",
       //                overflow: TextOverflow.ellipsis,
       //                style: DefaultStyle.textStyle(
       //                    color: DefaultColors.secondaryColor,
       //                    fontWeight: FontWeight.w700,
       //                    size: 18
       //                ),),
       //            ],
       //          ),
       //        ],
       //      ),
       //    ),
       //  ),
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
                    Text("Senha: ${widget.pass!}",
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
        SizedBox(height: 24,),
        Card(
          elevation: 10,
          child: Padding(padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Icon(
                Icons.info_outlined,
                color: DefaultColors.secondaryColor,
              ),
              SizedBox(width: 10,),
              Text("Observação: ${widget.ob!}",
                overflow: TextOverflow.ellipsis,
                style: DefaultStyle.textStyle(
                  color: DefaultColors.secondaryColor,
                  fontWeight: FontWeight.w700,
                  size: 18
              ),),
            ],),
            IconButton(onPressed: (){_copyobservation();}, icon: Icon(Icons.copy)),

          ],

          )

            ,),
        ),
      ],
    );
  }

  _copy(){
    FlutterClipboard.copy(widget.pass!).then(( value ) =>
        print('copied'));
    DefaultScreenUtils.onMessage(context: context, message: "Senha copiada para sua Área de transferência!", isError: false);
  }
  _copyPlataform(){
    FlutterClipboard.copy(widget.local!).then(( value ) =>
        print('copied'));
    DefaultScreenUtils.onMessage(context: context, message: "Senha copiada para sua Área de transferência!", isError: false);
  }
  _copyobservation(){
    FlutterClipboard.copy(widget.ob!).then(( value ) =>
        print('copied'));
    DefaultScreenUtils.onMessage(context: context, message: "Senha copiada para sua Área de transferência!", isError: false);
  }
}
