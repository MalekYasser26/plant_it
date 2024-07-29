import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_it/constants/constants.dart';

class CustCheckoutTextField extends StatelessWidget {
  final String text ;
  final Widget custIcon ;
  final bool phone ;
  const CustCheckoutTextField({super.key, required this.text, required this.custIcon, required this.phone});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: phone ? TextInputType.phone : TextInputType.text,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        labelText: text,
        labelStyle: GoogleFonts.montserrat(
          fontSize:  getResponsiveFontSize(context, fontSize: 16),
        ),
        suffixIcon: custIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.green[50],
      ),
    );
  }
}
