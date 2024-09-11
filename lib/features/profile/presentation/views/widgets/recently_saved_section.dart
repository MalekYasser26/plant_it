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
                //Navigator.push(context, MaterialPageRoute(builder: (context) => const RecentlySavedView(),));
                pCubit.getRecentlySavedProducts(11);
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
              if (state is RecentlySavedLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors.darkGreenL,
                  ),
                );
              }
              if (state is RecentlySavedSuccessfulState) {
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return IntrinsicWidth(
                      child: SavedItem(
                        index: index,
                        price: state.products[index].price,
                        name: state.products[index].productName,
                        image: state.products[index].image,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  itemCount: state.products.length.clamp(0, 4),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
