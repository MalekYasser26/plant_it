import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';

class CartItem extends StatelessWidget {
  final int index;
  const CartItem({
    super.key, required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/plant$index.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Monstera Plant",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: getResponsiveSize(context, fontSize: 19),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "2x",
                          style: TextStyle(
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.bold,
                            fontSize: getResponsiveSize(context, fontSize: 16),
                          ),
                        ),
                        const Row(
                          children: [
                            Text(
                              "EGP ",
                              style: TextStyle(
                                fontFamily: "Raleway",
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              "220 ",
                              style: TextStyle(
                                fontFamily: "Raleway",
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // const CustRatingStars(),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -15,  // Adjust position to place the close button above the container
          right: 10, // Adjust position to align the close button correctly
          child: GestureDetector(
            onTap: () {
              print("Close button tapped");
            },
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.greyish
                )

              ),
              child: Icon(
                Icons.close,
                size: getResponsiveSize(context, fontSize: 25),
                color: Colors.black54,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
