import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/auth/presentation/view_model/signup/signup_cubit.dart';
import 'package:plant_it/features/auth/presentation/views/log_in_view.dart';
import 'package:plant_it/features/auth/presentation/views/widgets/confirm_password_field.dart';
import 'package:plant_it/features/auth/presentation/views/widgets/cust_text_field.dart';
import 'package:plant_it/features/auth/presentation/views/widgets/email_widget.dart';
import 'package:plant_it/features/auth/presentation/views/widgets/join_through_widget.dart';
import 'package:plant_it/features/auth/presentation/views/widgets/login_button.dart';
import 'package:plant_it/features/auth/presentation/views/widgets/password_widget.dart';
import 'package:plant_it/features/home/presentation/views/home_view.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    var sCubit = context.read<SignupCubit>();
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: AppColors.basicallyWhite),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ImagesCust.logo,
                    width: 70,
                    height: 70,
                  ),
                  Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: getResponsiveSize(context, fontSize: 32),
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkGreen,
                      fontFamily: "Poppins",
                    ),
                  ),
                  const SizedBox(height: 40),
                  const CustTextField(
                    text: "Name",
                    custIcon: Icon(Icons.person),
                    aboveText: "Your name",
                  ),
                  const SizedBox(height: 20),
                  const EmailField(
                    aboveText: "Email",
                  ),
                  const SizedBox(height: 20),
                  const PasswordField(
                    aboveText: "Password",
                  ),
                  const SizedBox(height: 20),
                  const ConfirmPasswordField(),
                  const SizedBox(height: 20),
                  CustButton(
                    text: "Sign up",
                    onPressed: () {
                      print("Sign-up button pressed");
                      sCubit.signUp("m@gmail.com", "Mm@123", "username",
                          "displayedName", "011", "aa");
                      print("Sign-up method invoked");
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const JoinThroughWidget(),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: getResponsiveSize(context, fontSize: 14),
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                      // Default text color
                      children: [
                        TextSpan(
                          text: 'Sign in',
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize:
                                  getResponsiveSize(context, fontSize: 14),
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkGreen),
                          // Color for "Sign in"
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginView(),
                                  ));
                            },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
