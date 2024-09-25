import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/description/presentation/views/description_view.dart';
import 'package:plant_it/features/home/presentation/view_model/home_product.dart';

class LikedFrame extends StatefulWidget {
  final String imagePath,productName ;
  final String price ;
  final int likeCounter ;
  final int id ;
  const LikedFrame({super.key, required this.imagePath, required this.productName, required this.price, required this.likeCounter, required this.id});

  @override
  State<LikedFrame> createState() => _LikedFrameState();
}

class _LikedFrameState extends State<LikedFrame> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    HomeProduct p = HomeProduct(id: widget.id, productName: "", price: '', likesCounter: -2, image: '') ;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  DescriptionView(
                    product: p,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFFE3DDDD),
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(10),
                    child: widget.imagePath.startsWith('http') ?
                    CachedNetworkImage(
                      imageUrl: widget.imagePath,
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
                      'assets/images/placeholder.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    widget.productName,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: getResponsiveSize(context, fontSize: 15),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    isPressed = !isPressed;
                    setState(() {
                    });
                  },
                  child:  isPressed
                      ? Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: getResponsiveSize(context, fontSize: 20),
                  )
                      : Icon(
                    Icons.favorite_border,
                    size: getResponsiveSize(context, fontSize: 20),
                  ),
                )


              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "${widget.price} EGP",
                    style: TextStyle(
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold,
                      fontSize: getResponsiveSize(context, fontSize: 15),
                    ),
                  ),
                ),
                Text(
                  widget.likeCounter.toString(),
                  style: TextStyle(
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.bold,
                    fontSize: getResponsiveSize(context, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
