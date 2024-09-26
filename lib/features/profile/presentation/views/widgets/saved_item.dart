import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/description/presentation/views/description_view.dart';
import 'package:plant_it/features/home/presentation/view_model/home_product.dart';
import 'package:plant_it/features/profile/presentation/views/widgets/fixed_rating_stars.dart';
import 'package:shimmer/shimmer.dart';

class SavedItem extends StatelessWidget {
  final int index, id;
  final int ?rating;
  final String name, image, price;

  const SavedItem({
    super.key,
    required this.index,
    required this.price,
    required this.name,
    required this.image,
    required this.id, required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    HomeProduct p = HomeProduct(
        id: id,
        productName: "w",
        price: '10',
        likesCounter: 1,
        image: 's'
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xFFF8F9EF),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            height: 90,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DescriptionView(product: p),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: image.isNotEmpty && image != 'null' // Check for a valid image URL
                    ? CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: AppColors.lighterGreen,
                    highlightColor: AppColors.barelyGreen,
                    child: Container(
                      color: Colors.white,
                      height: 150,
                      width: double.infinity,
                    ),
                  ),
                  errorWidget: (context, url, error) {
                    return Image.asset(
                      'assets/images/placeholder.png',
                      fit: BoxFit.cover,
                      height: 150,
                      width: double.infinity,
                    );
                  },
                  fadeInDuration: const Duration(milliseconds: 500),
                  fadeOutDuration: const Duration(milliseconds: 500),
                )
                    : Image.asset(
                  'assets/images/placeholder.png', // Use a placeholder if the image URL is invalid
                  fit: BoxFit.cover,
                  height: 150,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4.0, left: 3),
                  child: Text(
                    name,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: getResponsiveSize(context, fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Row(
                    children: [
                      const Text(
                        "EGP ",
                        style: TextStyle(
                          fontFamily: "Raleway",
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        "$price ",
                        style: const TextStyle(
                          fontFamily: "Raleway",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                 FixedRatingStars(
                  rating: rating??0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
