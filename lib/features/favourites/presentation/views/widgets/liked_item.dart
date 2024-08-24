import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_it/constants/constants.dart';

class LikedItem extends StatelessWidget {
  final int index ;
  const LikedItem({
    super.key, required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                child: Image.asset(
                  'assets/images/plant$index.png',
                  fit: BoxFit.cover,
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
                      "Monstera Plant",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: getResponsiveSize(context,
                            fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SvgPicture.asset(
                      IconsCust.likedIcon,
                      height: 13,
                      width: 14,
                    ),
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
                          "222 ",
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
    );
  }
}
