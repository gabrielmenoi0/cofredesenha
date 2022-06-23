import 'package:cofredesenha/data/cache/strings.dart';
import 'package:cofredesenha/utils/styles.dart';
import 'package:cofredesenha/utils/textStyle.dart';
import 'package:flutter/material.dart';

class PasswordCheckWidget extends StatelessWidget {
  final String password;
  final bool hasUppercase;
  final bool hasLowercase;
  final bool hasSpecialCharacters ;
  final bool hasMinLength;
  final bool hasDigits;

  const PasswordCheckWidget({Key? key,
    required this.password,
    this.hasUppercase = true,
    this.hasLowercase = true,
    this.hasSpecialCharacters = true,
    this.hasMinLength = true,
    this.hasDigits = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int minLengh = 6;

    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = password.length >= minLengh;
    bool hasDigits = password.contains(RegExp(r'[0-9]'));

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sua senha deve conter:",
          textAlign: TextAlign.left,
          style: DefaultStyle.textStyle(
              size: 14,
              fontWeight: FontWeight.w500
          ),
        ),
        const SizedBox(height: margin),
        Visibility(
          visible: this.hasMinLength,
          child: Row(
            children: [
              _icon(hasMinLength),
              const SizedBox(width: margin/2),
              Text(
                "$minLengh caracteres",
                textAlign: TextAlign.left,
                style: DefaultStyle.textStyle(
                    color: _color(hasMinLength),
                    size: 16,
                    fontWeight: FontWeight.w400
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: margin/2),
        Visibility(
          visible: this.hasDigits,
          child: Row(
            children: [
              _icon(hasDigits),
              const SizedBox(width: margin/2),
              Text(
                "Pelo menos um número",
                textAlign: TextAlign.left,
                style: DefaultStyle.textStyle(
                    color: _color(hasDigits),
                    size: 16,
                    fontWeight: FontWeight.w400
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: margin/2),
        Visibility(
          visible: this.hasSpecialCharacters,
          child: Row(
            children: [
              _icon(hasSpecialCharacters),
              const SizedBox(width: margin/2),
              Text(
                "Pelo menos um caractere especial",
                textAlign: TextAlign.left,
                style: DefaultStyle.textStyle(
                    color: _color(hasSpecialCharacters),
                    size: 16,
                    fontWeight: FontWeight.w400
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: margin/2),
        Visibility(
          visible: this.hasUppercase,
          child: Row(
            children: [
              _icon(hasUppercase),
              const SizedBox(width: margin/2),
              Text(
                "Pelos menos uma letra maiúscula",
                textAlign: TextAlign.left,
                style: DefaultStyle.textStyle(
                    color: _color(hasUppercase),
                    size: 16,
                    fontWeight: FontWeight.w400
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: margin/2),
        Visibility(
          visible: this.hasLowercase,
          child: Row(
            children: [
              _icon(hasLowercase),
              const SizedBox(width: margin/2),
              Text(
                "Pelos menos uma letra minúscula",
                textAlign: TextAlign.left,
                style: DefaultStyle.textStyle(
                    color: _color(hasLowercase),
                    size: 16,
                    fontWeight: FontWeight.w400
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _icon(bool isOk) {
    if(isOk) {
      return const Icon(Icons.check_circle_outline, size: 24, color: DefaultColors.successColor);
    }

    return const Icon(Icons.radio_button_unchecked_sharp, size: 24, color: DefaultColors.dangerColor);
  }

  Color _color(bool isOk) {
    if(isOk) {
      return DefaultColors.successColor;
    }

    return DefaultColors.dangerColor;
  }

}