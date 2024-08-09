import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';

class CustButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text ;
  const CustButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getResponsiveSize(context, fontSize: 306),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkGreenL,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
        child:  Text(text,
            style: TextStyle(
                fontFamily: "Poppins",
              fontSize:  getResponsiveSize(context, fontSize: 18),
              color: Colors.white,
              fontWeight: FontWeight.bold
            )
        ),
      ),
    );
  }
}
