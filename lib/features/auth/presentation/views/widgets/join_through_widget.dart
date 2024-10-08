import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/auth/presentation/view_model/auth_cubit.dart';

class JoinThroughWidget extends StatelessWidget {
  const JoinThroughWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var sCubit = context.read<AuthCubit>();
    return Column(
      children: [
        Text(
          "Or",
          style: TextStyle(
              color: AppColors.darkGreen,
              fontFamily: "Poppins",
              fontSize: getResponsiveSize(context, fontSize: 16),
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "Join through",
          style: TextStyle(
              color: AppColors.darkGreen,
              fontFamily: "Poppins",
              fontSize: getResponsiveSize(context, fontSize: 16),
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                sCubit.signInWithGoogle(context);
              },
              child: Image.asset(
                ImagesCust.googleLogo,
                height: 30,
                width: 30,
              ),
            ),
            SizedBox(width: 30,),
            InkWell(
              onTap: () {
                sCubit.signOutFromGoogle(context);
              },
              child: Image.asset(
                ImagesCust.facebookLogo,
                height: 30,
                width: 30,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
