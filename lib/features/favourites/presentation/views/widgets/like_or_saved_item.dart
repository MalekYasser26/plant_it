import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/description/presentation/views/description_view.dart';
import 'package:shimmer/shimmer.dart';

class LikedOrSavedItem extends StatelessWidget {
  final int index ;
  final bool isLiked;
  final String name , image ;
  final double price ;
  const LikedOrSavedItem({
    super.key, required this.index, required this.isLiked, required this.name, required this.image, required this.price,
  });

  @override
  Widget build(BuildContext context) {
   // HomeProduct p = HomeProduct(id: 1, productName: "w", price: '10', likesCounter: 1, image: 's') ;
    return InkWell(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) =>  DescriptionView(
        //   product: p,
        // ),));

      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xFFF8F9EF),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Container(
                height: 90,
                width: 83,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFE3DDDD),
                    width: 1,
                  ),
                ),
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
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          fontSize: getResponsiveSize(context,
                              fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 10),
                      isLiked ? SvgPicture.asset(
                        IconsCust.likedIcon,
                        height: 13,
                        width: 14,
                      ) : SizedBox.shrink(),
                      const Spacer(),
                      // PopupMenuButton(itemBuilder: (context) {
                      //   return {'Logout', 'Settings'}.map((String choice) {
                      //     return PopupMenuItem<String>(
                      //       value: choice,
                      //       child: Text(choice),
                      //     );
                      //   }).toList();                                }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "EGP ",
                            style: TextStyle(
                              fontFamily: "Raleway",
                              fontSize: getResponsiveSize(context,
                                  fontSize: 18),
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            "$price ",
                            style: TextStyle(
                              fontFamily: "Raleway",
                              fontSize: getResponsiveSize(context,
                                  fontSize: 22),
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  RatingStars(
                    axis: Axis.horizontal,
                    value: 5,
                    starCount: 5,
                    starSize: getResponsiveSize(context, fontSize: 15),
                    starSpacing: 5,
                    valueLabelVisibility: false,
                    valueLabelPadding: const EdgeInsets.symmetric(
                        vertical: 1, horizontal: 8),
                    valueLabelMargin: const EdgeInsets.only(right: 8),
                    starOffColor: Colors.blueGrey.withOpacity(0.5),
                    starColor: const Color(0xFFFFCB45),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
