import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';

class CheckoutItem extends StatelessWidget {
  final int index,quantity;
  final String name,image ;
  final double price ;
  const CheckoutItem({
    super.key, required this.index, required this.quantity, required this.name, required this.price, required this.image,
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: image.startsWith('http') ?
              CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                width: double.infinity,
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
              ) : Image.asset(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Text(
                    name,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: getResponsiveSize(context, fontSize: 19),

                    ),
                  ),
                ),
                Text(
                  "${quantity}x",
                  style: TextStyle(
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.bold,
                    fontSize: getResponsiveSize(context, fontSize: 16),
                  ),
                ),
                 Row(
                  children: [
                    const Text(
                      "EGP ",
                      style: TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      "${price*quantity} ",
                      style: const TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                // const CustRatingStars(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
