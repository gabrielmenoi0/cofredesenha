import 'package:cofredesenha/utils/styles.dart';
import 'package:cofredesenha/utils/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultTextField extends StatefulWidget {
  const DefaultTextField({Key? key,
    this.textEditingController,
    this.autofocus,
    this.enabled,
    this.maxLength,
    this.hintText,
    this.labelText,
    this.helperText,
    this.keyboardType,
    this.textInputAction,
    this.onSaved,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.prefixIcon,
    this.suffixWidget,
    this.prefixWidget,
    this.floatingLabelBehavior,
    this.inputFormatters,
    this.autoValidateMode,
    this.hasBorder = true,
    this.isPassword = false,
    this.style,
    this.textAlign,
    this.minLines,
    this.maxLines
  }) : super(key: key);

  final TextEditingController? textEditingController;
  final bool? autofocus;
  final bool? enabled;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FormFieldSetter<String>? onSaved;
  final String? Function(String?)? validator;
  final AutovalidateMode? autoValidateMode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final List<TextInputFormatter>? inputFormatters;
  final bool hasBorder;
  final TextStyle? style;
  final TextAlign? textAlign;
  final bool isPassword;

  @override
  _DefaultTextField createState() => _DefaultTextField();
}

class _DefaultTextField extends State<DefaultTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      autofocus: widget.autofocus ?? false,
      enabled: widget.enabled,
      maxLength: widget.maxLength,
      onSaved: widget.onSaved,
      minLines: widget.minLines,
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      style: widget.style ?? DefaultStyle.textStyle(
        size: 16,
        fontWeight: FontWeight.w500,
        color: DefaultColors.textColor
      ),
      textAlign: widget.textAlign ?? TextAlign.start,
      validator: (value) {
        if(widget.validator != null) {
          return widget.validator!(value!);
        }

        return null;
      },
      autovalidateMode: widget.autoValidateMode,
      obscureText: widget.isPassword ? _obscureText : false,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      textInputAction: widget.textInputAction ?? TextInputAction.done,
      decoration: InputDecoration(
        floatingLabelBehavior: widget.floatingLabelBehavior,
        enabledBorder: widget.hasBorder ? const UnderlineInputBorder(
            borderSide: BorderSide(
                color: DefaultColors.darkColor99
            )
        ) : InputBorder.none,
        focusedBorder: widget.hasBorder ? const UnderlineInputBorder(
          borderSide: BorderSide(
            color: DefaultColors.darkColor99
          )
        ) : InputBorder.none,
        border: widget.hasBorder ? const UnderlineInputBorder(
            borderSide: BorderSide(
                color: DefaultColors.darkColor99
            )
        ) : InputBorder.none,
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        prefix: widget.prefixWidget,
        suffix: widget.isPassword ? GestureDetector(
          child: Icon(
            _obscureText ? Icons.visibility_off: Icons.visibility,
            color: DefaultColors.textColor,
          ),
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ) : widget.suffixWidget,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        fillColor: Colors.white,
        errorMaxLines: 3,
        errorStyle: const TextStyle(
          color: Colors.red
        ),
        labelStyle: DefaultStyle.textStyle(
          size: 16,
          fontWeight: FontWeight.w400,
          color: DefaultColors.darkColor2
        ),
        floatingLabelStyle: DefaultStyle.textStyle(
          size: 20,
          fontWeight: FontWeight.w400,
          color: DefaultColors.darkColor2
        ),
        hintStyle: DefaultStyle.textStyle(
          size: 20,
          fontWeight: FontWeight.w400,
          color: DefaultColors.lightColor2
        )
      ),
    );
  }
}

