import 'package:cofredesenha/utils/styles.dart';
import 'package:cofredesenha/utils/textStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageRegister extends StatefulWidget {

  final String? image;
  final String? text;
  const PageRegister(
      {Key? key,this.image, this.text})
      : super(key: key);

  @override
  _PageRegisterState createState() => _PageRegisterState();
}

class _PageRegisterState extends State<PageRegister> {
  // var mask = MaskTextInputFormatter(mask: "(##) # ####-####");
  bool checkCharacters = false;
  bool checkNumber = false;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // _header(),
        SizedBox(
        height: 30,
      ),
          _content(),
        ],
      ),
    );
  }

  _header() {
    return SizedBox(
      height: 30,
    );
  }

  _content() {
    return Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(
              //   height: 20,
              // ),

              Image.asset(widget.image!,height: 300),
              SizedBox(height: 10,),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(widget.text!,
                    textAlign: TextAlign.center,
                    style: DefaultStyle.textStyle(
                    color: DefaultColors.darkColor2,
                    fontWeight: FontWeight.w700,
                    size: 24
                  ),)
                  ),
              SizedBox(height: 15,),
            ],
          ),
        ),
    );
  }

  _openSuccess() {
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => Privacy()));
  }
}
