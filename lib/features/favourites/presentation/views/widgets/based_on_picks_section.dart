import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/favourites/presentation/views/widgets/liked_frame.dart';

class BasedOnPicksSection extends StatelessWidget {
  const BasedOnPicksSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
          crossAxisCount: 6,  // Controls the total width
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: const [
            StaggeredGridTile.count(
              crossAxisCellCount: 3,
              mainAxisCellCount: 6,
              child: LikedFrame(imagePath: 'assets/images/plant4.png'),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 3,
              mainAxisCellCount: 3,
              child: LikedFrame(imagePath: 'assets/images/plant5.png'),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 3,
              mainAxisCellCount: 3,
              child: LikedFrame(imagePath: 'assets/images/plant6.png'),
            ),
          ],
        ),
      ],
    );
  }
}
