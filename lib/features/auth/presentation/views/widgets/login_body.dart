import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/auth/presentation/view_model/signin/signin_cubit.dart';
import 'package:plant_it/features/auth/presentation/views/sign_up_view.dart';
import 'package:plant_it/features/auth/presentation/views/widgets/email_widget.dart';
import 'package:plant_it/features/auth/presentation/views/widgets/join_through_widget.dart';
import 'package:plant_it/features/auth/presentation/views/widgets/login_button.dart';
import 'package:plant_it/features/auth/presentation/views/widgets/password_widget.dart';
import 'package:plant_it/features/cust_nav_bar/presentation/views/cust_nav_bar_selection_view.dart';

class LoginBody extends StatelessWidget {
  LoginBody({super.key});

  // Controllers for email and password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Form key to manage validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var sCubit = context.read<SigninCubit>();
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: AppColors.basicallyWhite),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: BlocConsumer<SigninCubit, SigninState>(
                  listener: (context, state) {
                    if (state is SigninSuccessState) {
                      // Navigate on successful login
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CustNavBarSelectionView(currentIndex: 0),
                        ),
                      );
                    } else if (state is SigninFailureState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            sCubit.errorMsg,
                            style: const TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: AppColors.darkGreen,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImagesCust.logo,
                            width: 70,
                            height: 70,
                          ),
                          Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize:
                                  getResponsiveSize(context, fontSize: 32),
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkGreen,
                              fontFamily: "Poppins",
                            ),
                          ),
                          const SizedBox(height: 40),
                          // Email field with validation
                          EmailField(
                            aboveText: "Email",
                            controller: emailController,
                          ),
                          const SizedBox(height: 20),
                          // Password field with validation
                          PasswordField(
                            aboveText: "Password",
                            controller: passwordController,
                          ),
                          const SizedBox(height: 20),
                          // Show a circular progress indicator while loading
                          state is SigninLoadingState
                              ? const CircularProgressIndicator(
                                  color: AppColors.darkGreenL,
                                )
                              : CustButton(
                                  text: "Sign in",
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      // If form is valid, proceed with login
                                      sCubit.signIn(
                                        emailController.text,
                                        passwordController.text,
                                      );
                                    }
                                  },
                                ),
                          const SizedBox(height: 25),
                          const JoinThroughWidget(),
                          const SizedBox(
                            height: 50,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Don\'t have an account yet ? ',
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize:
                                      getResponsiveSize(context, fontSize: 14),
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                              children: [
                                TextSpan(
                                  text: 'Sign up',
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: getResponsiveSize(context,
                                          fontSize: 14),
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.darkGreen),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpView(),
                                        ),
                                      );
                                    },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
