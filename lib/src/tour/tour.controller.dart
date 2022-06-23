import 'package:cofredesenha/src/home/viewPassword.dart';
import 'package:cofredesenha/src/register/register.steps.view.dart';
import 'package:flutter/material.dart';

class TourController {


  late PageController pageController;
  int currentPage = 0;
  int currentPage_ = 0;

  Future<bool> backWill(BuildContext context)  async {
    bool back = false;
    if(this.currentPage > 0){
      onStepBack(context);
      back = false;
    }else{
    }
    return back;
  }


  void onStepBack(BuildContext context) async {
    if (this.currentPage > 0) {
      if(this.currentPage !=6){
        this.currentPage--;

        FocusScope.of(context).unfocus();
        pageController.animateToPage(this.currentPage, duration: Duration(milliseconds: 300), curve: Curves.ease);}

      if(this.currentPage==6){
        this.currentPage--;
        this.currentPage--;
        print(currentPage);
        FocusScope.of(context).unfocus();
        pageController.animateToPage(this.currentPage, duration: Duration(milliseconds: 300), curve: Curves.ease);
      }


    }

  }


  void onStepNext(BuildContext context) async {
    // if(!validateForm()) return;


    if (this.currentPage <4 ) {

      if(this.currentPage == 0) {
        this.currentPage++;
        FocusScope.of(context).unfocus();
        pageController.animateToPage(this.currentPage,
            duration: Duration(milliseconds: 300), curve: Curves.ease);
      } else if (this.currentPage <4){
        // if (this.currentPage == 5) await getPolicyTerm();

        this.currentPage++;
        print(currentPage);

        FocusScope.of(context).unfocus();
        pageController.animateToPage(this.currentPage,
            duration: Duration(milliseconds: 300), curve: Curves.ease);
      }
    }else{
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => RegisterStepsView()));
    }

  }

  void nextPage(BuildContext context) {
    this.currentPage++;
    FocusScope.of(context).unfocus();
    this.pageController.animateToPage( this.currentPage , duration: Duration(milliseconds: 300), curve: Curves.ease);
  }
}