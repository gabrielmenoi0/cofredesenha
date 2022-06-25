import 'package:cofredesenha/localAuthService.dart';
import 'package:cofredesenha/src/home.dart';
import 'package:cofredesenha/src/login.dart';
import 'package:cofredesenha/utils/button.dart';
import 'package:cofredesenha/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:cofredesenha/utils/images.dart';


class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {

  final ValueNotifier<bool> isLocalAuthFailed = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    checkLocalAuth();
  }

  checkLocalAuth() async {
    // final auth = context.read<LocalAuthService>();
    final auth = LocalAuthService(
      auth: LocalAuthentication(),
    );
    // Future<bool> authenticateIsAvailable() async {
    //   final isAvailable = await auth.canCheckBiometrics;
    //   final isDeviceSupported = await auth.isDeviceSupported();
    //   return isAvailable && isDeviceSupported;
    // }

    final isLocalAuthAvailable = await auth.isBiometricAvailable();
    isLocalAuthFailed.value = false;

    if (isLocalAuthAvailable) {
      final authenticated = await auth.authenticate();

      if (!authenticated) {
        // if (!mounted) return;
        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeView()), (Route<dynamic> route) => false);
        // Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(builder: (BuildContext context) => HomeView()));
      }
      if (authenticated) {
        // if (!mounted) return;
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Home()), (Route<dynamic> route) => false);
        // Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(builder: (BuildContext context) => HomeView()));
      }
      isLocalAuthFailed.value = true;
    } else {
      // if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => login()), (Route<dynamic> route) => false);      // isLocalAuthFailed.value = false;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultColors.secondaryColor,
      body: ValueListenableBuilder<bool>(
        valueListenable: isLocalAuthFailed,
        builder: (context, failed, _) {
          if (failed) {
            return Visibility(
              visible: !isLocalAuthFailed.value,
              child: Center(
                child: DefaultButton(
                  fillColor: DefaultColors.secondaryColor,
                  context: context,
                  callback: checkLocalAuth,
                  title: "Tentar autenticar novamente",
                ),
              ),
            );
          }
          if (!failed) {
            return Column(
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
            );
            // return Center(
            //   child: DefaultButton(
            //     context: context,
            //     callback: checkLocalAuth,
            //     title: "Tentar autenticar novamente",
            //   ),
            // );
          }
          return Column(
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
          );
        },
      ),
    );
  }
}
