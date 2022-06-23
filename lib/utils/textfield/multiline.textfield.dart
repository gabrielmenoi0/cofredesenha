import 'package:cofredesenha/utils/styles.dart';
import 'package:cofredesenha/utils/textStyle.dart';
import 'package:flutter/material.dart';

class AppMultilineTextField extends StatefulWidget {
  const AppMultilineTextField({Key? key,
    this.textEditingController,
    this.enabled,
    this.maxLength,
    this.hintText,
    this.labelText,
    this.helperText,
    this.textInputAction,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.labelStyle,
  }) : super(key: key);

  final TextEditingController? textEditingController;
  final bool? enabled;
  final int? maxLength;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final TextInputAction? textInputAction;
  final FormFieldSetter<String>? onSaved;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final String? labelStyle;

  @override
  _AppMultilineTextField createState() => _AppMultilineTextField();
}

class _AppMultilineTextField extends State<AppMultilineTextField> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      enabled: widget.enabled,
      maxLength: widget.maxLength,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      keyboardType: TextInputType.multiline,
      textInputAction: widget.textInputAction ?? TextInputAction.done,
      minLines: 1,
      maxLines: 3,
      style: DefaultStyle.textStyle(
          size: 16,
          fontWeight: FontWeight.w500
      ),
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: DefaultColors.secondaryColor),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        fillColor: Colors.white,
        errorMaxLines: 3,
        errorStyle: const TextStyle(
            color: Colors.red
        ),
        labelStyle: DefaultStyle.textStyle(
            size: 20,
            color: DefaultColors.darkColor2,
            fontWeight: FontWeight.w400),
        floatingLabelStyle: DefaultStyle.textStyle(
            size: 20,
            color: DefaultColors.darkColor2,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}

