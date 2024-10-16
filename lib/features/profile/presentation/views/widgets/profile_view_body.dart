import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:plant_it/features/auth/presentation/views/log_in_view.dart';
import 'package:plant_it/features/checkout/presentation/widgets/cust_app_bar.dart';
import 'package:plant_it/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:plant_it/features/profile/presentation/views/widgets/hi_bruno_section.dart';
import 'package:plant_it/features/profile/presentation/views/widgets/recent_purchases_section.dart';
import 'package:plant_it/features/profile/presentation/views/widgets/recently_saved_section.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  @override
  Widget build(BuildContext context) {
    var sCubit = context.read<AuthCubit>();
    var pCubit = context.read<ProfileCubit>();
    return SafeArea(
      child: Stack(
        children: [
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return const Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: AppColors.basicallyWhite,
                appBar: CustAppBar(
                  text: "Your profile",
                  implyLeading: false,
                ),
                body: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HiBrunoSection(),
                    //  YourInfoSection(),
                      RecentPurchasesSection(),
                      RecentlySavedSection(),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            right: 0,
            top: 5,
            child: IconButton(
                onPressed: () {
                  pCubit.clearGroupedByStatus();
                  sCubit.logOut(context);
                  sCubit.googleSignOut(context);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginView(),
                    ),
                    (route) => false,
                  );
                },
                icon: const Icon(
                  Icons.logout_rounded,
                  size: 30,
                  color: Colors.red,
                )),
          ),
        ],
      ),
    );
  }
}
