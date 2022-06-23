import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultStyle {
  static TextStyle textStyle({
    double size = 14,
    FontWeight fontWeight = FontWeight.w400,
    Color color = Colors.black,
    bool isUnderlined = false
  }) {
    return GoogleFonts.lato(
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
      decoration: isUnderlined ? TextDecoration.underline : null,
    );
  }
}