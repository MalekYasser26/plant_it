import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/favourites/presentation/view_model/liked_plants_cubit.dart';
import 'package:plant_it/features/favourites/presentation/views/widgets/liked_frame.dart';

class BasedOnPicksSection extends StatefulWidget {
  const BasedOnPicksSection({
    super.key,
  });

  @override
  State<BasedOnPicksSection> createState() => _BasedOnPicksSectionState();
}

class _BasedOnPicksSectionState extends State<BasedOnPicksSection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikedPlantsCubit, LikedPlantsState>(
      builder: (context, state) {
        if (state is LikedSuggestedPlantsCombinedState){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Based on your picks',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: getResponsiveSize(context, fontSize: 25),
              ),
            ),
            const SizedBox(height: 10),
            // Staggered grid that adapts to screen size
            StaggeredGrid.count(
              crossAxisCount: 6, // Controls the total width
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: [
                StaggeredGridTile.count(
                  crossAxisCellCount: 3,
                  mainAxisCellCount: 6,
                  child: LikedFrame(
                    price: state.productSuggestions[0].price,
                    imagePath: state.productSuggestions[0].image.toString(),
                    likeCounter:state.productSuggestions[0].likesCounter,
                    productName:state.productSuggestions[0].productName,
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 3,
                  mainAxisCellCount: 3,
                  child: LikedFrame(
                    price: state.productSuggestions[1].price,
                    imagePath: state.productSuggestions[1].image.toString(),
                    likeCounter:state.productSuggestions[1].likesCounter,
                    productName:state.productSuggestions[1].productName,
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 3,
                  mainAxisCellCount: 3,
                  child: LikedFrame(
                    price: state.productSuggestions[0].price,
                    imagePath: state.productSuggestions[0].image.toString(),
                    likeCounter:state.productSuggestions[0].likesCounter,
                    productName:state.productSuggestions[0].productName,
                  ),
                ),
              ],
            ),
          ],
        );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
