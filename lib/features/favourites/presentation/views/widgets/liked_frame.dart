import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/description/presentation/views/description_view.dart';
import 'package:plant_it/features/home/presentation/view_model/home_product.dart';

class LikedFrame extends StatefulWidget {
  final String imagePath ;
  const LikedFrame({super.key, required this.imagePath});

  @override
  State<LikedFrame> createState() => _LikedFrameState();
}

class _LikedFrameState extends State<LikedFrame> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    HomeProduct p = HomeProduct(id: 1, productName: "w", price: '10', likesCounter: 1, image: 's') ;

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
                    child: Image.asset(
                      widget.imagePath,
                      fit: BoxFit.cover, // Adjusted to cover to fill the container
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
                    "Monstera",
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
                    "222 EGP",
                    style: TextStyle(
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold,
                      fontSize: getResponsiveSize(context, fontSize: 15),
                    ),
                  ),
                ),
                Text(
                  "1.4 K",
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
