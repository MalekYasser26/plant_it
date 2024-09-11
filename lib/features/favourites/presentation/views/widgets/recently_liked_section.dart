import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/favourites/presentation/view_model/liked_plants_cubit.dart';
import 'package:plant_it/features/favourites/presentation/views/widgets/like_or_saved_item.dart';

class RecentlyLikedSection extends StatelessWidget {
  const RecentlyLikedSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
            fontSize: getResponsiveSize(context, fontSize: 25),
          ),
        ),
        const SizedBox(height: 10),
        // Remove Expanded, let ListView build inside SingleChildScrollView
        BlocBuilder<LikedPlantsCubit, LikedPlantsState>(
          builder: (context, state) {
            if (state is RecentlyLikedLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: AppColors.darkGreenL,
                ),
              );
            }
            if (state is RecentlyLikedSuccessfulState) {
              int totalItems = state.products.length;
              if (totalItems <= 2) {
                // If there are fewer than two items, show all available items
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return LikedOrSavedItem(
                      index: index + 1,
                      isLiked: true,
                      name: state.products[index].productName,
                      image: state.products[index].image,
                      price: state.products[index].price,
                    );
                  },
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemCount: totalItems, // Show all available items
                );
              }

              // Otherwise, show the last two items
              return ListView.separated(
                itemBuilder: (context, index) {
                  // Get the last two items
                  int reversedIndex = totalItems - 2 + index; // Get last two elements
                  return LikedOrSavedItem(
                    index: reversedIndex + 1,
                    isLiked: true,
                    name: state.products[reversedIndex].productName,
                    image: state.products[reversedIndex].image,
                    price: state.products[reversedIndex].price,
                  );
                },
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                itemCount: 2, // Only show two items
              );
            }
            return const SizedBox.shrink();
          },
        ),

      ],
    );
  }
}
