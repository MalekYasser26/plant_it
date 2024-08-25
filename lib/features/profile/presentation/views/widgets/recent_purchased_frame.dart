import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/profile/presentation/views/widgets/fixed_rating_stars.dart';

class RecentPurchasedFrame extends StatelessWidget {
  final String imagePath;
  const RecentPurchasedFrame({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF9F7),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath, // Image path
              width: 80,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          // Middle Section (Plant Details)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(width: 3,),
                    Text(
                      "Monstera plant",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: getResponsiveSize(context, fontSize: 13),
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "Ordered: 12th May 2024",
                      style: TextStyle(
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w400,
                        fontSize: getResponsiveSize(context, fontSize: 10),
                        color: Colors.black54,
                      ),
                    ),

                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const SizedBox(width: 3,),
                    Text(
                      "222 EGP",
                      style: TextStyle(
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w300,
                        fontSize: getResponsiveSize(context, fontSize: 12),
                        color: Colors.black54,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "State: Arrived",
                      style: TextStyle(
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.w300,
                        fontSize: getResponsiveSize(context, fontSize: 11),
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FixedRatingStars(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

