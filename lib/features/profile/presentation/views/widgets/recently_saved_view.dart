import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/checkout/presentation/widgets/cust_app_bar.dart';
import 'package:plant_it/features/favourites/presentation/views/widgets/like_or_saved_item.dart';

class RecentlySavedView extends StatelessWidget {
  const RecentlySavedView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.basicallyWhite,
        appBar: const CustAppBar(text: "Recently Saved",
          implyLeading: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(top: 20), // Add padding to the top
                    itemBuilder: (context, index) =>  LikedOrSavedItem(
                      index: index + 1,
                      price: 220,
                      image: "",
                      name: "mONSTERA",
                      isLiked: false,
                    ),
                    separatorBuilder: (context, index) =>
                    const SizedBox(height: 30),
                    itemCount: 6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
