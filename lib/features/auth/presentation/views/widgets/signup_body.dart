import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/auth/presentation/views/widgets/confirm_password_field.dart';
import 'package:plant_it/features/auth/presentation/views/widgets/cust_text_field.dart';
import 'package:plant_it/features/auth/presentation/views/widgets/email_widget.dart';
import 'package:plant_it/features/auth/presentation/views/widgets/login_button.dart';
import 'package:plant_it/features/auth/presentation/views/widgets/password_widget.dart';
import 'package:plant_it/features/home/presentation/views/home_view.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF66BB6A),
                Color(0xFF43A047),
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Plant It',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const CustTextField(text: "First name", custIcon: Icon(Icons.person),),
                  const SizedBox(height: 20),
                  const CustTextField(text: "Last name", custIcon: Icon(Icons.person),),
                  const SizedBox(height: 20),
                  const CustTextField(text: "Phone", custIcon: Icon(Icons.phone),),
                  const SizedBox(height: 20),
                  const EmailField(),
                  const SizedBox(height: 20),
                  const PasswordField(),
                  const SizedBox(height: 20),
                  const ConfirmPasswordField(),
                  const SizedBox(height: 20),
                  CustButton(
                    text: "Register",
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeView(),));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
}
