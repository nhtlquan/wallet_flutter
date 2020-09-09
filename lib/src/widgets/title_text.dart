import 'package:flutter/material.dart';
import 'package:flutter_wallet_app/src/theme/light_color.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final int line ;
  final FontWeight fontWeight;

  const TitleText(
      {Key key,
      this.text,
      this.line = 99,
      this.fontSize = 18,
        this.fontWeight = FontWeight.w800,
      this.color = LightColor.navyBlue2})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text,
          maxLines: line,
          style: GoogleFonts.muli(
              fontSize: fontSize, fontWeight: fontWeight, color: color)),
    );
  }
}
