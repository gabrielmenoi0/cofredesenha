
import 'package:cofredesenha/utils/styles.dart';
import 'package:cofredesenha/utils/textStyle.dart';
import 'package:flutter/material.dart';


class DefaultScreenUtils {
  static onMessage({
    required BuildContext context,
    required String message,
    required bool isError,
    SnackBarAction? action,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          message,
          style: DefaultStyle.textStyle(
              size: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white
          )
      ),
      action: action,
      backgroundColor: isError ? Colors.redAccent : DefaultColors.secondaryColor,
    ));
  }

  static onDialog({
    required BuildContext context,
    required String title,
    required String message,
    required bool isError,
    List<Widget>? action,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(title,
              style: DefaultStyle.textStyle(
                  size: 20,
                  fontWeight: FontWeight.w700,
                  color: isError ? DefaultColors.secondaryColorDark : DefaultColors.primaryColorDark
              )),
          content: Text(
              message,
              style: DefaultStyle.textStyle(
                  size: 16,
                  fontWeight: FontWeight.w400,
                  color: DefaultColors.textColor
              )),
          actions: action,
        );
      },
    );
  }


  static onLoading() {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
      ),
    );
  }
}
