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
    var pCubit = context.read<ProfileCubit>();

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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RecentlySavedView()),
                );
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
        SizedBox(
          height: 100, // Set a fixed height for the ListView
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              // Check if the state is loading
              if (state is RecentlySavedLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors.darkGreenL,
                  ),
                );
              }

              // Check if the state is successful and has saved products
              if (state is RecentlySavedSuccessfulState) {
                final savedProducts = state.savedProducts.reversed.toList(); // Reverse the list to get the most recent items
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: savedProducts.length.clamp(0, 3), // Display the last 3 saved products
                  itemBuilder: (context, index) {
                    final product = savedProducts[index]; // Access each product
                    return IntrinsicWidth(
                      child: SavedItem(
                        index: index,
                        price: product.price.toString(), // Use actual product price
                        name: product.name, // Use actual product name
                        image: product.imgUrl ?? 'assets/images/placeholder.png',
                        id: product.id, // Pass the product ID
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(width: 10),
                );
              }

              // If there's an error loading the products
              if (state is RecentlySavedFailureState) {
                return const Center(
                  child: Text('Failed to load recently saved products'),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        )
      ],
    );
  }
}