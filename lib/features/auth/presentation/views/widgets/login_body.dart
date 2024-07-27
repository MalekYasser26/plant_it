import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/auth/presentation/views/sign_up_view.dart';
import 'package:plant_it/features/auth/presentation/views/widgets/email_widget.dart';
import 'package:plant_it/features/auth/presentation/views/widgets/password_widget.dart';
import 'package:plant_it/features/home/presentation/views/home_view.dart';
import 'login_button.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

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
                  const EmailField(),
                  const SizedBox(height: 20),
                  const PasswordField(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) =>const SignUpView() ,)),
                        child: Text("Don't have an account ? SIGN UP ",
                        style: GoogleFonts.montserrat(
                          fontSize: getResponsiveFontSize(context, fontSize: 16),
                          color: Colors.white
                        ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustButton(
                    text: "Login",
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
