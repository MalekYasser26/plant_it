import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';

class EmailField extends StatelessWidget {
  final String aboveText;
  final TextEditingController controller; // Add controller
  const EmailField({Key? key, required this.aboveText, required this.controller})
      : super(key: key);

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
        const SizedBox(height: 10),
        TextFormField(
          controller: controller, // Set controller here
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email cannot be empty';
            }
            return null;
          },
          onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(
              fontFamily: "Poppins",
              fontSize: getResponsiveSize(context, fontSize: 16),
              color: AppColors.darkGreen,
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.darkGreen),
            ),
            prefixIcon: const Icon(Icons.email),
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
