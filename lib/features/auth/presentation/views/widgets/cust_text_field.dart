import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';

class CustTextField extends StatelessWidget {
  final String text,aboveText ;
  final Widget custIcon ;
  const CustTextField({super.key, required this.text, required this.custIcon, required this.aboveText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(aboveText,style: TextStyle(
          fontFamily: "Raleway",
          color: AppColors.darkGreen,
          fontWeight: FontWeight.w600,
          fontSize: getResponsiveSize(context, fontSize: 16,),

        ),),
        const SizedBox(height: 10,),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
          decoration: InputDecoration(
            labelText: text,
            labelStyle: TextStyle(
                fontFamily: "Poppins",
              fontSize:  getResponsiveSize(context, fontSize: 16),
                color: AppColors.darkGreen
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppColors.darkGreen
              ), ),
            prefixIcon: custIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Colors.green[50],
          ),
        ),
      ],
    );
  }
}
