import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/favourites/presentation/view_model/liked_plants_cubit.dart';
import 'package:plant_it/features/favourites/presentation/views/widgets/liked_frame.dart';
import 'package:plant_it/features/home/presentation/view_model/home_product_cubit.dart';

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
    var hCubit = context.read<HomeProductsCubit>();
    return hCubit.cachedProducts.isNotEmpty ?BlocBuilder<LikedPlantsCubit, LikedPlantsState>(
      builder: (context, state) {
        if (state is LikedSuggestedPlantsCombinedState) {
          List combinedProducts = [];
          if (state.productSuggestions.length >= 3) {
            for (int i = 0; i < 3; i++) {
              combinedProducts.add(state.productSuggestions[i]);
            }
          } else if (state.productSuggestions.length < 3) {
            for (int i = 0; i < state.productSuggestions.length; i++) {
              combinedProducts.add(state.productSuggestions[i]);
            }
            for (int i = 0; i < 3 - state.productSuggestions.length; i++) {
              // Check if the item from hCubit.cachedProducts is already in combinedProducts
              bool exists = combinedProducts.any((product) => product.id == hCubit.cachedProducts[i].id);

              if (!exists) {
                // Add the item to combinedProducts if it's not found by id
                combinedProducts.add(hCubit.cachedProducts[i]);
              }
            }
          }
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
                      price: combinedProducts[0].price.toString(),
                      imagePath:combinedProducts[0].image.toString(),
                      likeCounter: combinedProducts[0].likesCounter,
                      productName: combinedProducts[0].productName,
                      id: combinedProducts[0].id,
                    ),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 3,
                    mainAxisCellCount: 3,
                    child: LikedFrame(
                      price: combinedProducts[1].price.toString(),
                      imagePath: combinedProducts[1].image.toString(),
                      likeCounter: combinedProducts[1].likesCounter,
                      productName: combinedProducts[1].productName,
                      id: combinedProducts[1].id,
                    ),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 3,
                    mainAxisCellCount: 3,
                    child: LikedFrame(
                      price: combinedProducts[2].price.toString(),
                      imagePath: combinedProducts[2].image.toString(),
                      likeCounter: combinedProducts[2].likesCounter,
                      productName: combinedProducts[2].productName,
                      id: combinedProducts[2].id,
                    ),
                  ),
                ],
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    ) : const SizedBox.shrink();
  }
}
