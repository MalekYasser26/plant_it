import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/home/presentation/view_model/home_product.dart';
import 'package:plant_it/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:plant_it/features/profile/presentation/views/widgets/fixed_rating_stars.dart';
import 'package:shimmer/shimmer.dart';

class SavedItem extends StatelessWidget {
  final int index;
  final double price ;
  final String name,image ;
  const SavedItem({
    super.key, required this.index, required this.price, required this.name, required this.image,
  });

  @override
  Widget build(BuildContext context) {
    HomeProduct p = HomeProduct(id: 1, productName: "w", price: '10', likesCounter: 1, image: 's') ;
    var pCubit = context.read<ProfileCubit>();
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
                // Navigator.push(context, MaterialPageRoute(builder: (context) =>  DescriptionView(
                //   product: p,
                // ),));
                pCubit.getRecentlySavedProducts(11);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
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
                  padding: const EdgeInsets.only(right: 4.0,left: 3),
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
                const FixedRatingStars(),
              ],
            ),
          ),
        ],
      ),
    );

  }
}
