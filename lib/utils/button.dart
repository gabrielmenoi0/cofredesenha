import 'package:cofredesenha/utils/styles.dart';
import 'package:cofredesenha/utils/textStyle.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final BuildContext context;
  final String title;
  final Widget? leading;
  final VoidCallback? callback;
  final double height;

  //STYLE
  final Color? borderColor;
  final Color? textColor;
  final Color? fillColor;
  final double borderRadius;

  //MARGIN
  final EdgeInsetsGeometry? padding;

  const DefaultButton({Key? key,
    required this.context,
    required this.title,
    this.callback,
    this.height = 56,
    this.leading,
    this.borderColor = Colors.transparent,
    this.textColor = Colors.white,
    this.fillColor = DefaultColors.secondaryColor,
    this.borderRadius = 6,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => _button();

  _button() {
    return Container(
      padding: padding,
      child: SizedBox(
        height: height,
        child: leading == null ? ElevatedButton(
          onPressed: callback,
          child: _title(),
          style: _style(),
        ) : ElevatedButton.icon(
          onPressed: callback,
          label: _title(),
          icon: leading!,
          style: _style(),
        ),
      ),
    );
  }

  _title() => Text(
    title,
    textAlign: TextAlign.center,
    style: DefaultStyle.textStyle(
        size: 20,
        fontWeight: FontWeight.w800,
        color: textColor ?? Colors.black
    )
  );

  _style() => ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: BorderSide(width: borderColor != null ? 2 : 0, color: borderColor != null ? borderColor! : Colors.transparent)
          )
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.grey;
        }

        return fillColor!; // Defer to the widget's default.
      }),
      elevation: MaterialStateProperty.all<double>(0)
  );
}
