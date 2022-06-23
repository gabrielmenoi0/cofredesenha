
import 'package:cofredesenha/utils/passwordCheck.dart';
import 'package:cofredesenha/utils/styles.dart';
import 'package:cofredesenha/utils/textStyle.dart';
import 'package:cofredesenha/utils/textfield/textfield.dart';
import 'package:cofredesenha/utils/validations/general.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


class RegisterPasswordStepWidget extends StatefulWidget {
  final String value;
  final Function(String?) onSaved;
  final Function onSubmit;

  const RegisterPasswordStepWidget({Key? key, required this.onSaved, required this.onSubmit, required this.value}) : super(key: key);

  @override
  _RegisterPasswordStepWidget createState() => _RegisterPasswordStepWidget();
}

class _RegisterPasswordStepWidget extends State<RegisterPasswordStepWidget> {

  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirm = TextEditingController();
  var mask = MaskTextInputFormatter(mask: "######");


  @override
  void initState() {
    super.initState();
    _password.text = widget.value;
    _confirm.text = widget.value;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text.rich(
                TextSpan(
                    children: [
                      TextSpan(
                        text: "Guarde esta senha",
                        style: DefaultStyle.textStyle(
                            size: 20,
                            fontWeight: FontWeight.w700,
                            color: DefaultColors.secondaryColor
                        ),
                      ),
                      TextSpan(
                        text: ", ela poderá ser solicitada  no futuro para sua ",
                        style: DefaultStyle.textStyle(
                            size: 20,
                            fontWeight: FontWeight.w400,
                            color: DefaultColors.textColor
                        ),
                      ),
                      TextSpan(
                        text: "segurança!",
                        style: DefaultStyle.textStyle(
                            size: 20,
                            fontWeight: FontWeight.w700,
                            color: DefaultColors.secondaryColor
                        ),
                      ),
                    ])),
            const SizedBox(
              height: 10,
            ),
            DefaultTextField(
              inputFormatters: [mask],
              prefixIcon: Icon(Icons.key, color: DefaultColors.secondaryColor,),
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
              textEditingController: _password,
              textInputAction: TextInputAction.next,
              // validator: (value) => Validator.validateLength(value ?? ""),
              onSaved: (value) => widget.onSaved(value),
              isPassword: true,
              hintText: "Crie uma senha",
              onChanged: (_) {
                setState(() {});
              },
            ),
            const SizedBox(
              height: 10,
            ),
            DefaultTextField(
              inputFormatters: [mask],
              prefixIcon: Icon(Icons.key, color: DefaultColors.secondaryColor,),
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
              textEditingController: _confirm,
              textInputAction: TextInputAction.next,
              validator: (value) => Validator.validateCompareNumber(_password.text, value ?? ""),
              isPassword: true,
              hintText: "Confirme a senha",
              onChanged: (_) {
                setState(() {});
              },
              onFieldSubmitted: (_) => widget.onSubmit(),
            ),
            const SizedBox(
              height: 10,
            ),
            PasswordCheckWidget(
              password: _password.text,
              hasMinLength: true,
              hasDigits: false,
              hasLowercase: false,
              hasSpecialCharacters: false,
              hasUppercase: false,
            )
          ],
        ),
      ),
    );
  }

}