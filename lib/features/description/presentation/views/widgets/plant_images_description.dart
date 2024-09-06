import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PlantImagesDescriptionWidget extends StatelessWidget {
  final List<String> imageLinks;

  const PlantImagesDescriptionWidget({super.key, required this.imageLinks});

  @override
  Widget build(BuildContext context) {
    // Limit the image links to the first 5 images
    final limitedImageLinks = imageLinks.take(5).toList();

    if (limitedImageLinks.length == 3) {
      return _buildThreeImageLayout(limitedImageLinks);
    } else if (limitedImageLinks.length == 5) {
      return _buildFiveImageLayout(limitedImageLinks);
    } else {
      // Fallback in case the number of images is different from 3 or 5
      return _buildFallbackLayout(limitedImageLinks);
    }
  }

  // Layout for exactly 3 images
  Widget _buildThreeImageLayout(List<String> images) {
    return StaggeredGrid.count(
      crossAxisCount: 6,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 6,
          mainAxisCellCount: 4,
          child: _buildImage(images[0]),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 3,
          mainAxisCellCount: 4,
          child: _buildImage(images[1]),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 3,
          mainAxisCellCount: 4,
          child: _buildImage(images[2]),
        ),
      ],
    );
  }

  // Layout for exactly 5 images (your current design)
  Widget _buildFiveImageLayout(List<String> images) {
    return StaggeredGrid.count(
      crossAxisCount: 6,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 5,
          child: _buildImage(images[0]),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: _buildImage(images[1]),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: _buildImage(images[2]),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 4,
          child: _buildImage(images[3]),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 3,
          child: _buildImage(images[4]),
        ),
      ],
    );
  }

  // Fallback layout in case the number of images is not 3 or 5
  Widget _buildFallbackLayout(List<String> images) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 images per row
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return _buildImage(images[index]);
      },
    );
  }

  // Function to build the image widget
  Widget _buildImage(String imageUrl) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      ),
    );
  }
}
