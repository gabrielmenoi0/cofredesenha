import 'dart:async';
import 'package:cofredesenha/src/message.view.dart';
import 'package:cofredesenha/utils/images.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {

  const Splash({Key? key}) : super(key: key);
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
      timer();
      // if (value) {
      //   Timer(Duration(seconds: 5), () {
      //     Navigator.pushReplacement(
      //         context,
      //         MaterialPageRoute(
      //             builder: (context) => Deliveries(
      //
      //             )));
      //   });
      // } else {
      //   Timer(Duration(seconds: 5), () {
      //     Navigator.of(context)
      //         .pushReplacement(MaterialPageRoute(builder: (_) => login()));
      //   });
      // }
  }
  timer(){
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MessageView()));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:
            EdgeInsets.only(left: 20, right: 20, top: 44.92, bottom: 46.55),
            child: Image.asset(
              DefaultAssets.logo,
              width: 559.67,
              height: 109.14,
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }

  // Future<bool> verifyToken() async {
  //   SharedPreferences sheredPreference = await SharedPreferences.getInstance();
  //   if (sheredPreference.getString('authorization') != null) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}
