import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/checkout/presentation/widgets/cust_app_bar.dart';
import 'package:plant_it/features/profile/presentation/views/widgets/hi_bruno_section.dart';
import 'package:plant_it/features/profile/presentation/views/widgets/recent_purchases_section.dart';
import 'package:plant_it/features/profile/presentation/views/widgets/saved_item.dart';
import 'package:plant_it/features/profile/presentation/views/widgets/your_info_section.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _CheckoutViewBodyState();
}

class _CheckoutViewBodyState extends State<ProfileViewBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.basicallyWhite,
        appBar: CustAppBar(
          text: "Your profile",
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HiBrunoSection(),
                YourInfoSection(),
                RecentPurchasesSection(),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recently saved",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: getResponsiveSize(context, fontSize: 20),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            print("show all");
                          },
                          style: const ButtonStyle(
                            backgroundColor:
                            WidgetStatePropertyAll(AppColors.greyish),
                          ),
                          child: Text(
                            "Show all",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w300,
                              fontSize: getResponsiveSize(context, fontSize: 15),
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 100,  // Set a fixed height for the ListView
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return IntrinsicWidth(child: SavedItem(index: index+1));
                        },
                        separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                        itemCount: 6,
                      ),
                    ),



                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



