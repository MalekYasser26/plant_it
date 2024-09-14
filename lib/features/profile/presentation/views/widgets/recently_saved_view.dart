import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/checkout/presentation/widgets/cust_app_bar.dart';
import 'package:plant_it/features/favourites/presentation/views/widgets/like_or_saved_item.dart';
import 'package:plant_it/features/profile/presentation/view_model/recently_saved_product_model.dart';

class RecentlySavedView extends StatelessWidget {
  final List<RecentlySavedProductModel> savedProducts; // Assuming you have a Product model

  const RecentlySavedView({super.key, required this.savedProducts});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.basicallyWhite,
        appBar: const CustAppBar(
          text: "Recently Saved",
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
                    itemBuilder: (context, index) {
                      final product = savedProducts[index]; // Get each product
                      return LikedOrSavedItem(
                        index: index + 1,
                        price: product.price, // Use product price
                        image: product.imgUrl ?? 'assets/images/placeholder.png', // Use product image
                        name: product.name, // Use product name
                        isLiked: false,
                        id: product.id, // Pass the product ID
                      );
                    },
                    separatorBuilder: (context, index) =>
                    const SizedBox(height: 30),
                    itemCount: savedProducts.length, // Show all saved products
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
