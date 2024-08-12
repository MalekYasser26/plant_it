import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/auth/presentation/view_model/signin/signin_cubit.dart';
import 'package:plant_it/features/auth/presentation/views/sign_up_view.dart';
import 'package:plant_it/features/auth/presentation/views/widgets/email_widget.dart';
import 'package:plant_it/features/auth/presentation/views/widgets/join_through_widget.dart';
import 'package:plant_it/features/auth/presentation/views/widgets/password_widget.dart';
import 'package:plant_it/features/cust_nav_bar/presentation/views/cust_nav_bar_selection_view.dart';
import 'login_button.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

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
                        fontSize: getResponsiveSize(context, fontSize: 32),
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkGreen,
                        fontFamily: "Poppins",
                      ),
                    ),
                    const SizedBox(height: 40),
                    const EmailField(
                      aboveText: "Email",
                    ),
                    const SizedBox(height: 20),
                    const PasswordField(
                      aboveText: "Password",
                    ),
                    const SizedBox(height: 20),
                    CustButton(
                      text: "Sign in ",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CustNavBarSelectionView(),
                            ));
                        // sCubit.signIn("malek@gmail.com", "Mm@123");
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
                            fontSize: getResponsiveSize(context, fontSize: 14),
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                        // Default text color
                        children: [
                          TextSpan(
                            text: 'Sign up',
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
                                      builder: (context) => const SignUpView(),
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
      ),
    );
  }
}
