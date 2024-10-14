import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/checkout/presentation/widgets/cust_app_bar.dart';
import 'package:plant_it/features/favourites/presentation/views/widgets/based_on_picks_section.dart';
import 'package:plant_it/features/favourites/presentation/views/widgets/recently_liked_section.dart';

class FavouritesViewBody extends StatefulWidget {
  const FavouritesViewBody({super.key});

  @override
  State<FavouritesViewBody> createState() => _FavouritesViewBodyState();
}

class _FavouritesViewBodyState extends State<FavouritesViewBody> {
  @override
  Widget build(BuildContext context) {
    return  const SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.basicallyWhite,
        appBar: CustAppBar(
          text: "Liked plants",
          implyLeading: false,
        ),
        // Wrap with SingleChildScrollView to allow scroll on smaller devices
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RecentlyLikedSection(),
                SizedBox(height: 10),
                BasedOnPicksSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
