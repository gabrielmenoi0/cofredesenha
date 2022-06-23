import 'package:cofredesenha/data/database.dart';
import 'package:cofredesenha/src/login.dart';
import 'package:cofredesenha/src/home/viewPassword.dart';
import 'package:cofredesenha/src/tour/tour_view.dart';
import 'package:cofredesenha/utils/button.dart';
import 'package:cofredesenha/utils/images.dart';
import 'package:cofredesenha/utils/styles.dart';
import 'package:cofredesenha/utils/textStyle.dart';
import 'package:flutter/material.dart';

class MessageView extends StatefulWidget {
  const MessageView({Key? key}) : super(key: key);

  @override
  _MessageView createState() => _MessageView();
}

class _MessageView extends State<MessageView> {

  final _formKey = GlobalKey<FormState>();
  final DatabaseProvider _dbHelper = DatabaseProvider.db;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  String data = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _content()
    );
  }
  

  _content() {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 150,
                  child: Image.asset(
                    DefaultAssets.mensagem,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Bom te ver por aqui!\nNosso app veio para assegurar suas senhas e poupar seu tempo",
                  textAlign: TextAlign.center,
                  style: DefaultStyle.textStyle(
                      size: 18,
                      fontWeight: FontWeight.w700,
                      color: DefaultColors.textColor
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                DefaultButton(
                  context: context,
                  title: "Começar",
                  callback: () => _open(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  _open() async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const login()));
  }

}


