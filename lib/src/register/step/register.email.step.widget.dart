import 'package:cofredesenha/utils/styles.dart';
import 'package:cofredesenha/utils/textStyle.dart';
import 'package:cofredesenha/utils/textfield/textfield.dart';
import 'package:cofredesenha/utils/validations/general.dart';
import 'package:flutter/material.dart';


class RegisterEmailStepWidget extends StatefulWidget {
  final String value;
  final Function(String?) onSaved;
  final Function onSubmit;

  const RegisterEmailStepWidget({Key? key, required this.onSaved, required this.onSubmit, required this.value}) : super(key: key);

  @override
  _RegisterEmailStepWidget createState() => _RegisterEmailStepWidget();
}

class _RegisterEmailStepWidget extends State<RegisterEmailStepWidget> {

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.value;
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
            Text(
              "Agora, qual é o seu e-mail?",
              textAlign: TextAlign.left,
              style: DefaultStyle.textStyle(
                  size: 24,
                  fontWeight: FontWeight.w400,
                  color: DefaultColors.textColor
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            DefaultTextField(
              prefixIcon: Icon(Icons.email, color: DefaultColors.secondaryColor,),
              textEditingController: _textEditingController,
              textInputAction: TextInputAction.next,
              validator: (value) => Validator.validateEmail(value ?? ""),
              onSaved: (value) => widget.onSaved(value),
              onFieldSubmitted: (_) => widget.onSubmit(),
              keyboardType: TextInputType.emailAddress,
            )
          ],
        ),
      ),
    );
  }

}