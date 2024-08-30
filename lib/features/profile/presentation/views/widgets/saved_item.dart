import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/description/presentation/views/description_view.dart';
import 'package:plant_it/features/profile/presentation/views/widgets/fixed_rating_stars.dart';

class SavedItem extends StatelessWidget {
  final int index;
  const SavedItem({
    super.key, required this.index,
  });

  @override
  Widget build(BuildContext context) {
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DescriptionView(
                  productId: 1,
                ),));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/plant$index.png',
                  fit: BoxFit.cover,
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
                    "Monstera Plant",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: getResponsiveSize(context, fontSize: 16),

                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 3.0),
                  child: Row(
                    children: [
                      Text(
                        "EGP ",
                        style: TextStyle(
                          fontFamily: "Raleway",
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        "220 ",
                        style: TextStyle(
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
