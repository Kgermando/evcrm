import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText({ Key? key ,
       this.text,
       this.size,
       this.color,
       this.weight}) : super(key: key);
  final String? text;
  final double? size;
  final Color? color;
  final FontWeight? weight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(fontSize: size, color: color, fontWeight: weight)
      ),
    );
  }
}
 