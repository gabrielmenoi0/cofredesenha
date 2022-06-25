import 'package:cofredesenha/auth.dart';
import 'package:cofredesenha/data/database.dart';
import 'package:cofredesenha/models/cliente.dart';
import 'package:cofredesenha/splash.dart';
import 'package:cofredesenha/src/home.dart';
import 'package:cofredesenha/src/login.dart';
import 'package:cofredesenha/src/message.view.dart';
import 'package:cofredesenha/src/home/viewPassword.dart';

import 'package:cofredesenha/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }
  final DatabaseProvider _dbHelper = DatabaseProvider.db;
  Cliente client = Cliente();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: DefaultColors.secondaryColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light
    ));

    Intl.defaultLocale = 'pt_BR';
    initializeDateFormatting('pt_BR');
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: DefaultTheme.themeData,
        home: FutureBuilder<Cliente?>(
          future: getAuth(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Splash();
            } else {
              if(snapshot.hasData) {
                return FutureBuilder<bool?>(
                  future: getSecurity(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else {
                      if(snapshot.hasData && snapshot.data) {
                        return MessageView();
                        // se tiver true o Security AuthCheck se n Home
                        // return  a == null || json.decode(a!)["authSecurity"] == "0"?  HomeView() : AuthCheck();
                      }else{
                        return AuthCheck();
                      }
                    }
                  },
                );
                // se tiver true o Security AuthCheck se n Home
                // return  a == null || json.decode(a!)["authSecurity"] == "0"?  HomeView() : AuthCheck();
              } else {
                return MessageView();
              }
            }
          },
        ),
    );
  }
  Future<bool?> getSecurity() async{

    String? a = await _dbHelper.getSecurity();
    if(a == null) return true;
    return a.toString().split("authSecurity:").last.split("}").first == " 0";
  }
  Future<Cliente?> getAuth() async {

    client = await _dbHelper.getCustomer();

    return client;
  }
}