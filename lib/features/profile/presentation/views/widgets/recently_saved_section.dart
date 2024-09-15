import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:plant_it/features/profile/presentation/views/widgets/recently_saved_view.dart';
import 'package:plant_it/features/profile/presentation/views/widgets/saved_item.dart';

class RecentlySavedSection extends StatefulWidget {
  const RecentlySavedSection({
    super.key,
  });

  @override
  State<RecentlySavedSection> createState() => _RecentlySavedSectionState();
}

class _RecentlySavedSectionState extends State<RecentlySavedSection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Column(
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
                    if (state is RecentlySavedSuccessfulState ) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RecentlySavedView(),
                        ),
                      );
                    }
                  },
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(AppColors.greyish),
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
            // The content part which changes based on state
            SizedBox(
              height: 100, // Set a fixed height for the ListView
              child: () {
                // Show loading spinner when in loading state
                // if (state is RecentlySavedLoadingState) {
                //   return const Center(
                //     child: CircularProgressIndicator(
                //       backgroundColor: AppColors.darkGreenL,
                //     ),
                //   );
                // }

                // Show the saved items list if the state is successful
                if (state is RecentlySavedSuccessfulState) {
                  final savedProducts = state.savedProducts.reversed
                      .toList(); // Reverse the list to get the most recent items
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: savedProducts.length.clamp(0, 3),
                    // Display the last 3 saved products
                    itemBuilder: (context, index) {
                      final product = savedProducts[index]; // Access each product
                      return IntrinsicWidth(
                        child: SavedItem(
                          index: index,
                          price: product.price.toString(),
                          // Use actual product price
                          name: product.name,
                          // Use actual product name
                          image: product.imgUrl.toString(),
                          id: product.id, // Pass the product ID
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(width: 10),
                  );
                }

                // Show error message if state failed
                if (state is RecentlySavedFailureState) {
                  return const Center(
                    child: Text('Failed to load recently saved products'),
                  );
                }

                // By default, return an empty view
                return const SizedBox.shrink();
              }(),
            ),
          ],
        );
      },
    );

  }
}
