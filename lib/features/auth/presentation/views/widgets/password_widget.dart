import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';

class PasswordField extends StatefulWidget {
  final String aboveText;
  final TextEditingController controller; // Add controller
  const PasswordField({Key? key, required this.aboveText, required this.controller})
      : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.aboveText,
          style: TextStyle(
            fontFamily: "Raleway",
            color: AppColors.darkGreen,
            fontWeight: FontWeight.w600,
            fontSize: getResponsiveSize(context, fontSize: 16),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: widget.controller, // Set controller here
          keyboardType: TextInputType.visiblePassword,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password cannot be empty';
            }
            return null;
          },
          onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
          obscureText: _obscureText,
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(
              fontFamily: "Poppins",
              fontSize: getResponsiveSize(context, fontSize: 16),
              color: AppColors.darkGreen,
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.darkGreen),
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
