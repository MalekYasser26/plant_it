import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_it/constants/constants.dart';

class CustTextField extends StatelessWidget {
  final String text ;
  final Widget custIcon ;
  const CustTextField({super.key, required this.text, required this.custIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        labelText: text,
        labelStyle: GoogleFonts.montserrat(
          fontSize:  getResponsiveFontSize(context, fontSize: 16),
        ),
        prefixIcon: custIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.green[50],
      ),
    );
  }
}
