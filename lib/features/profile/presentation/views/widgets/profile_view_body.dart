import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/checkout/presentation/widgets/cust_app_bar.dart';
import 'package:plant_it/features/profile/presentation/views/widgets/hi_bruno_section.dart';
import 'package:plant_it/features/profile/presentation/views/widgets/recent_purchases_section.dart';
import 'package:plant_it/features/profile/presentation/views/widgets/recently_saved_section.dart';
import 'package:plant_it/features/profile/presentation/views/widgets/your_info_section.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.basicallyWhite,
        appBar: CustAppBar(
          text: "Your profile",
          implyLeading: false,
        ),
        body: const Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HiBrunoSection(),
              YourInfoSection(),
              RecentPurchasesSection(),
              RecentlySavedSection(),
            ],
          ),
        ),
      ),
    );
  }
}