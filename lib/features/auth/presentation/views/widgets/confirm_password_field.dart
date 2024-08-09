import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';

class ConfirmPasswordField extends StatefulWidget {
  const ConfirmPasswordField({super.key});

  @override
  _ConfirmPasswordFieldState createState() => _ConfirmPasswordFieldState();
}

class _ConfirmPasswordFieldState extends State<ConfirmPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Confirm Password",
          style: TextStyle(
            fontFamily: "Raleway",
            color: AppColors.darkGreen,
            fontWeight: FontWeight.w600,
            fontSize: getResponsiveSize(
              context,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 10,),
        TextFormField(
          keyboardType: TextInputType.visiblePassword,
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus?.unfocus(),
          obscureText: _obscureText,
          decoration: InputDecoration(
            labelText: 'Confirm password',
            labelStyle: TextStyle(
              fontFamily: "Poppins",
              fontSize: getResponsiveSize(context, fontSize: 16),
              color: AppColors.darkGreen
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.darkGreen
              ),
            ),
            prefixIcon: const Icon(Icons.lock),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Colors.green[50],
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
