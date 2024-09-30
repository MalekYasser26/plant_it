import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/description/presentation/views/description_view.dart';
import 'package:plant_it/features/home/presentation/view_model/home_product.dart';
import 'package:plant_it/features/profile/presentation/views/widgets/fixed_rating_stars.dart';

class RecentPurchasedFrame extends StatelessWidget {
  final String imagePath,productName;
  final String price;
  final double rating ;
  final int id ;
  const RecentPurchasedFrame({super.key, required this.imagePath, required this.productName, required this.price, required this.rating, required this.id});

  @override
  Widget build(BuildContext context) {
    HomeProduct p = HomeProduct(id: 1, productName: "w", price: '10', likesCounter: 1, image: 's') ;

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
          Flexible(
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  DescriptionView(
                  product: p,
                ),));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: imagePath.startsWith('http') ?
                CachedNetworkImage(
                  imageUrl: imagePath,
                  fit: BoxFit.fitHeight,
                  height: 80,
                  errorWidget: (context, url, error) {
                    return Image.asset(
                      'assets/images/placeholder.png',
                      fit: BoxFit.cover,
                      height: 150,
                    );
                  },
                  fadeInDuration: const Duration(milliseconds: 500),
                  fadeOutDuration: const Duration(milliseconds: 500),
                ) : Image.asset(
                  'assets/images/placeholder.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
              flex: 3,
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.only(left: 3.0),
                      child: Text(
                        productName,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          fontSize: getResponsiveSize(context, fontSize: 13),
                          color: Colors.black,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height:5,),
                    Padding(
                      padding: const EdgeInsets.only(left: 3.0),
                      child: Text(
                        "$price EGP",
                        style: TextStyle(
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.w300,
                          fontSize: getResponsiveSize(context, fontSize: 13),
                          color: Colors.black54,
                
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 5,),
                     FixedRatingStars(
                      rating: rating ,
                    ),
                  ],
                ),
              ),
              // Flexible(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         "Orders: 12th May 2024",
              //         style: TextStyle(
              //           fontFamily: "Raleway",
              //           fontWeight: FontWeight.w400,
              //           fontSize: getResponsiveSize(context, fontSize: 12),
              //           color: Colors.black54,
              //         ),
              //         softWrap: true,
              //         overflow: TextOverflow.visible,
              //       ),
              //       Text(
              //         "State: Arrived",
              //         style: TextStyle(
              //           fontFamily: "Raleway",
              //           fontWeight: FontWeight.w300,
              //           fontSize: getResponsiveSize(context, fontSize: 12),
              //           color: Colors.black,
              //         ),
              //         softWrap: true,
              //         overflow: TextOverflow.visible,
              //       ),
              //     ],
              //   ),
              // )
            ],
          ))
        ],
      ),
    );
  }
}
