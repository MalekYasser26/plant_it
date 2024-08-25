import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/favourites/presentation/views/widgets/liked_item.dart';

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
        ListView.separated(
          itemBuilder: (context, index) {
            return LikedOrSavedItem(
              index: index + 1,
              isLiked: true,
            );
          },
          shrinkWrap: true, // Make ListView take up only as much space as it needs
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) {
            return const SizedBox(height: 10);
          },
          itemCount: 2,
        ),
      ],
    );
  }
}
