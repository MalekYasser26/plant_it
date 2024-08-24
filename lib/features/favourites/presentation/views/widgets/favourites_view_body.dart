import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/checkout/presentation/widgets/cust_app_bar.dart';
import 'package:plant_it/features/favourites/presentation/views/widgets/liked_item.dart';

class FavouritesViewBody extends StatelessWidget {
  const FavouritesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.basicallyWhite,
        appBar: const CustAppBar(
          text: "Liked plants",
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Recently liked",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: getResponsiveSize(context, fontSize: 30),
                  ),
                ),
                Expanded(
                  child: ListView.separated(itemBuilder: (context, index) {
                    return LikedItem(
                      index: index+1,
                    );
                  }, separatorBuilder: (context, index) {
                    return const SizedBox(height: 10,);
                  }, itemCount: 3),
                )
              ],
            )),
      ),
    );
  }
}

