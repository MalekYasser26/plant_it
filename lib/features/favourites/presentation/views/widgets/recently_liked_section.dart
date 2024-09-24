import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/favourites/presentation/view_model/liked_plants_cubit.dart';
import 'package:plant_it/features/favourites/presentation/view_model/recently_liked_products.dart';
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
                  color: AppColors.darkGreenL,
                ),
              );
            }
            if (state is RecentlyLikedSuccessfulState) {
              List<RecentlyLikedProductModel> revProducts = state.products.reversed.toList() ;
              return ListView.separated(
                itemBuilder: (context, index) {
                  return LikedOrSavedItem(
                    index: index ,
                    isLiked: true,
                    name:revProducts[index].productName,
                    image: revProducts[index].image,
                    price: revProducts[index].price,
                    id:revProducts[index].id ,
                  );
                },
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                itemCount:revProducts.length.clamp(0, 3)
              );
            }
            return const SizedBox.shrink();
          },
        ),

      ],
    );
  }
}
