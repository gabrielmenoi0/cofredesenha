import 'package:cofredesenha/src/home/viewPassword.dart';
import 'package:cofredesenha/src/register/register.steps.view.dart';
import 'package:cofredesenha/src/tour/page.tour.dart';
import 'package:cofredesenha/src/tour/tour.controller.dart';
import 'package:cofredesenha/utils/button.dart';
import 'package:cofredesenha/utils/images.dart';
import 'package:cofredesenha/utils/styles.dart';
import 'package:cofredesenha/utils/textStyle.dart';
import 'package:flutter/material.dart';

class Tour extends StatefulWidget {
  const Tour({Key? key}) : super(key: key);

  @override
  _TourState createState() => _TourState();
}

class _TourState extends State<Tour> {
  final controller = TourController();


  @override
  void initState() {
    super.initState();
    controller.pageController = PageController(
        initialPage: 0
    );
    controller.pageController.addListener(() {
      controller.currentPage_ = controller.pageController.page!.round();

      if (controller.currentPage != controller.currentPage_) {
        controller.currentPage_ = controller.currentPage;
      }

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultColors.lightColor1,
      appBar:AppBar(
          backgroundColor: DefaultColors.lightColor1,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: DefaultColors.secondaryColor,
              size: 20,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        actions: [TextButton(onPressed: finish, child: Text("Pular",style: DefaultStyle.textStyle(
          size: 14,
          fontWeight: FontWeight.w700,
            color:DefaultColors.secondaryColor
        ),))],
      ),
      body: SafeArea(
        child: _body(),
      ),
    );
  }
  finish(){
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterStepsView()));
  }

  _body() {
    return Column(
      children: [
        Expanded(
          child: _pages(),
        ),
        _button(),
      ],
    );
  }

  List<Widget> steps = [];

  _pages() {
    return Center(
      // key: controller.formKey,
      child: PageView(
          controller: controller.pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (page){
            setState(() {
              controller.currentPage = page;
            });
          },
          children: const [
            PageRegister(
              image: DefaultAssets.tour1,
              text: "Essa ?? sua barra de navega????o, onde voc?? pode alternar entre a tela inicial, o cadastro de contas e o seu perfil, respectivamente.",
            ),
            PageRegister(
              image: DefaultAssets.tour2,
              text: "Aqui que voc?? seleciona o tipo de conta que voc?? est?? cadastrando.",
            ),
            PageRegister(
              image: DefaultAssets.tour3,
              text: "Essa ?? sua tela de contas, onde voc?? pode filtrar por contas de redes sociais, banc??rias e outras, al??m de poder tamb??m pesquisar por uma conta espec??fica.",
            ),
            PageRegister(
              image: DefaultAssets.tour4,
              text: "O exemplo acima mostra como ficar??o listadas as suas contas de redes sociais.",
            ),
            PageRegister(
              image: DefaultAssets.tour5,
              text: "Aten????o! N??o desinstale ou limpe dos dados do aplicativo, pois voc?? perder?? as suas senhas!",
            ),

          ]
      ),
    );

  }
  List<Widget> pagesHere = [
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  Widget _buildBullets() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(pagesHere, (index, img) {
            return InkWell(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                width:  10,
                height: 10,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.currentPage_ >= index ?  DefaultColors.secondaryColor : Colors.white),
              ),
            );
          }
          )
      ),
    );
  }

  List<T> map<T>(list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  _button(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildBullets(),
        SizedBox(height: 10,),
        Padding(padding: EdgeInsets.all(10),child:DefaultButton(context: context, title: "Pr??ximo",callback:() => controller.onStepNext(context)))
      ],
    );

  }
}
