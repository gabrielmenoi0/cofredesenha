import 'package:cofredesenha/src/home.dart';
import 'package:cofredesenha/src/password/add/addBank.dart';
import 'package:cofredesenha/src/password/add/addOthers.dart';
import 'package:cofredesenha/src/password/add/addSocial.dart';
import 'package:cofredesenha/utils/styles.dart';
import 'package:cofredesenha/utils/textStyle.dart';
import 'package:flutter/material.dart';

class SelectType extends StatefulWidget {
  const SelectType({Key? key}) : super(key: key);

  @override
  _SelectType createState() => _SelectType();
}

class _SelectType extends State<SelectType> {

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
      // bottomNavigationBar: _button(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_back_ios,
        //     color: Colors.black,
        //     size: 20,
        //   ),
        //   onPressed: () {;
        //   Navigator.pop(context);
        //   Navigator.pushReplacement(
        //         context, MaterialPageRoute(builder: (context) => Home()));
        //   }
        // ),
        title: Text("Selecione o tipo de senha",
            style: DefaultStyle.textStyle(
                size: 24,
                fontWeight: FontWeight.w700,
                color: DefaultColors.darkColor2)),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  cardOption(action: (){social();},title: "Redes Sociais"),
                  cardOption(action: (){bank();},title: "Bancárias"),
                  cardOption(action: (){others();},title: "Outras"),
                ],
              )
          ),
        ),
      ),
    );
  }
  social(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddSocial()));
  }
  bank(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddBank()));
  }
  others(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddPassword()));
  }
  cardOption({required String title,required Function action}) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: DefaultColors.secondaryColor, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 10,
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
              selectedColor: Color.fromRGBO(218, 218, 221, 1),
              // selected: true,
              // selectedColor: Color.fromRGBO(218, 218, 221, 1),
              title: Text(title,
                textAlign: TextAlign.center,
                style: DefaultStyle.textStyle(
                color: DefaultColors.primaryColor,
                size: 18,
                fontWeight: FontWeight.w700,
              ),),
              onTap:() => action()
          ),
        ],
      ),
    );
  }

}
