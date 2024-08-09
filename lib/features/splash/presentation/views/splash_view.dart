import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/auth/presentation/views/sign_up_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.darkGreen,
                  AppColors.darkGreenL,
                  AppColors.normGreen,
                  AppColors.lightGreen,
                  AppColors.lighterGreen,
                  AppColors.barelyGreen,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpView(),));
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 100,
                  ),
                  backgroundColor: AppColors.basicallyWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child:  Text(
                  "Get Started",
                  style: TextStyle(
                    fontSize: getResponsiveSize(context, fontSize: 18),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: AppColors.darkGreenL,
                  ),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImagesCust.logo,height: 97,width: 100,),
              Text("Plant-it",style: TextStyle(
                fontSize: getResponsiveSize(context, fontSize: 32),
                fontWeight: FontWeight.w700,
                fontFamily: "Poppins",
                color: Colors.white
              ),),
            ],
          ),
        ],
      ),
    );
  }
}
