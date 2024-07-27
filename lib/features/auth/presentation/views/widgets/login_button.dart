import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_it/constants/constants.dart';

class CustButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text ;
  const CustButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
      child:  Text(text,
          style: GoogleFonts.montserrat(
            fontSize:  getResponsiveFontSize(context, fontSize: 16),
            color: Colors.white
          )
      ),
    );
  }
}
