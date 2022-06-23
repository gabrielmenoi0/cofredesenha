import 'package:cofredesenha/data/database.dart';
import 'package:cofredesenha/models/cliente.dart';
import 'package:cofredesenha/src/home/alterProfile.dart';
import 'package:cofredesenha/src/home/passwordGenerator.dart';
import 'package:cofredesenha/src/home/passwordGenerator2.dart';
import 'package:cofredesenha/src/message.view.dart';
import 'package:cofredesenha/utils/button.dart';
import 'package:cofredesenha/utils/images.dart';
import 'package:cofredesenha/utils/screenUtils.dart';
import 'package:cofredesenha/utils/styles.dart';
import 'package:cofredesenha/utils/textStyle.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}
final DatabaseProvider _dbHelper = DatabaseProvider.db;

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: _loadData() ,
    );
  }
  _loadData() {
    return Scaffold(
      body: FutureBuilder<Cliente>(
        future: _dbHelper.getCustomer(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return DefaultScreenUtils.onLoading();
          }
          Cliente? item = snapshot.data;

          return _body(item!);
        },
      ),
    );
  }
  Widget _body(Cliente userModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(20),
          color: DefaultColors.backgroundColorLight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Image.asset(DefaultAssets.mensagem),
              SizedBox(
                height: 30,
              ),
              Text(userModel.nome!,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: DefaultStyle.textStyle(
                      fontWeight: FontWeight.w400,
                      size: 20,
                      color: DefaultColors.darkColor2)),

            ],
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
              child: Padding(
    padding: EdgeInsets.all(10),child: _options(userModel),
    ),
            ))
      ],
    );
  }
  Widget _options(Cliente userModel) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: DefaultColors.secondaryColor, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10,
          color: Colors.white,
          child: ListTile(
              leading:Icon(Icons.edit,
                  color: DefaultColors.secondaryColor),
              // trailing: Icon(Icons.,
              //     color: DefaultColors.secondaryColor),
              // // subtitle: subTitle != null ? Text(subTitle) : null,
              title: Text(
                "Editar perfil",
                style: DefaultStyle.textStyle(
                    fontWeight: FontWeight.w400,
                    size: 20,
                    color: DefaultColors.darkColor2),
              ),
              onTap: (){

                Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => EditProfile(id: userModel.id,password: userModel.senha,email: userModel.email,name: userModel.nome,)));}),
        ),
        SizedBox(height: 10,),
        Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: DefaultColors.secondaryColor, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.white,
          child: ListTile(
              leading:Icon(Icons.key_outlined,
                  color: DefaultColors.secondaryColor),
              // trailing:  Icon(Icons.,
              //     color: DefaultColors.secondaryColor),
              // // subtitle: subTitle != null ? Text(subTitle) : null,
              title: Text(
                "Gerador de Senhas",
                style: DefaultStyle.textStyle(
                    fontWeight: FontWeight.w400,
                    size: 20,
                    color: DefaultColors.darkColor2),
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordGenerator2())),
              ),
        ),

        SizedBox(height: 10,),
        Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: DefaultColors.secondaryColor, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10,
          color: Colors.white,
          child: ListTile(
              leading:Icon(Icons.delete_forever,
                  color: DefaultColors.secondaryColor),
              // trailing: Icon(Icons.,
              //     color: DefaultColors.secondaryColor),
              // // subtitle: subTitle != null ? Text(subTitle) : null,
              title: Text(
                "Apagar conta",
                style: DefaultStyle.textStyle(
                    fontWeight: FontWeight.w400,
                    size: 20,
                    color: DefaultColors.darkColor2),
              ),
              onTap: (){
                bottomLogout(context);
              }),
        ),
        SizedBox(height: 10,),
        Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: DefaultColors.secondaryColor, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10,
          color: Colors.white,
          child: ListTile(
              leading:Icon(Icons.logout,
                  color: DefaultColors.secondaryColor),
              // trailing: Icon(Icons.,
              //     color: DefaultColors.secondaryColor),
              // // subtitle: subTitle != null ? Text(subTitle) : null,
              title: Text(
                "Deslogar",
                style: DefaultStyle.textStyle(
                    fontWeight: FontWeight.w400,
                    size: 20,
                    color: DefaultColors.darkColor2),
              ),
              onTap: (){
                bottomLogout2(context);
              }),
        ),

        // cardOption(
        //   icon: "exit",
        //   action: bottomLogout,
        //   title: "Deslogar",
        // ),
      ],
    );
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

  static BoxDecoration decorationBottom() => const BoxDecoration(
      color: Colors.white,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14), topRight: Radius.circular(14)));

  bottomLogout(BuildContext context) {
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
                          height: 20,
                        ),
                        Text(
                          "Você tem certeza que deseja apagar da sua conta?",
                          style: DefaultStyle.textStyle(
                              size: 20,
                              fontWeight: FontWeight.w400,
                              color: DefaultColors.darkColor1),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                child: DefaultButton(
                                  context: context,
                                  title: "Sim",
                                ),
                                onTap: _logout,
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
  bottomLogout2(BuildContext context) {
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
                          height: 20,
                        ),
                        Text(
                          "Você tem certeza que deseja deslogar da sua conta?",
                          style: DefaultStyle.textStyle(
                              size: 20,
                              fontWeight: FontWeight.w400,
                              color: DefaultColors.darkColor1),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                child: DefaultButton(
                                  context: context,
                                  title: "Sim",
                                ),
                                onTap: _logout2,
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
  _logout2(){
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MessageView()),
            (Route<dynamic> route) => false);
  }

  _logout() async {
    try{
      // await DeleteController().delete();
      var res = await _deleteUser();

      if (res) {

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MessageView()),
                (Route<dynamic> route) => false);
      }

    }catch(e){
      DefaultScreenUtils.onMessage(context: context, message: "Erro ao deslogar", isError: true);

    }

  }
  Future<bool> _deleteUser() async {
    try {

      await _dbHelper.deleteCustomer();


      return true;
    } catch (e, s) {
      DefaultScreenUtils.onMessage(
          context: context, message: "Falha ao desconectar!", isError: true);
      return false;
    }
  }
  cardOption(
      {required String icon,
        required String title,
        String? subTitle,
        required Function action}) {
    return Card(
      elevation: 1,
      color: Colors.white,
      child: ListTile(
          leading: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/$icon.png",
                  width: 25.0, height: 25.0, color: DefaultColors.secondaryColor, alignment: Alignment.topCenter)
            ],
          ),
          trailing: Image.asset(
            "assets/images/coolicon.png",
            width: 15.0,
            height: 15.0,
          ),
          subtitle: subTitle != null ? Text(subTitle) : null,
          title: Text(
            title,
            style: DefaultStyle.textStyle(
                fontWeight: FontWeight.w400,
                size: 20,
                color: DefaultColors.darkColor2),
          ),
          onTap: () => action()),
    );
  }


}
