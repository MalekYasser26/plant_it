import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';

class CustTextField extends StatelessWidget {
  final String text, aboveText;
  final Widget custIcon;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType ;
  const CustTextField({
    super.key,
    required this.text,
    required this.custIcon,
    required this.aboveText,
    required this.controller,
    required this.validator, required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          aboveText,
          style: TextStyle(
            fontFamily: "Raleway",
            color: AppColors.darkGreen,
            fontWeight: FontWeight.w600,
            fontSize: getResponsiveSize(context, fontSize: 16),
          ),
        ),
        const SizedBox(height: 10,),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
          decoration: InputDecoration(
            labelText: text,
            labelStyle: TextStyle(
              fontFamily: "Poppins",
              fontSize: getResponsiveSize(context, fontSize: 16),
              color: AppColors.darkGreen,
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.darkGreen,
              ),
            ),
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
