import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/description/presentation/views/description_view.dart';
import 'package:plant_it/features/home/presentation/view_model/product_model.dart';
import 'package:plant_it/features/home/presentation/view_model/products_cubit.dart';

class CustomFrame extends StatefulWidget {
  final Product product;
  final int index;
  const CustomFrame({super.key, required this.product, required this.index});

  @override
  State<CustomFrame> createState() => _CustomFrameState();
}

class _CustomFrameState extends State<CustomFrame> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // This will minimize the column size
        children: [
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DescriptionView(
                  productId: widget.index + 1,
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
                  // child: CachedNetworkImage(
                  //   imageUrl: widget.product.image,
                  //   fit: BoxFit.cover,
                  //   height: 150, // Set a height for the image
                  //   width: double.infinity,
                  //   placeholder: (context, url) =>
                  //       Image.asset('assets/images/plant6.png'
                  //       ),
                  //   errorWidget: (context, url, error) {
                  //       return const Padding(
                  //         padding: EdgeInsets.all(8.0),
                  //         child: CircularProgressIndicator(
                  //           color: AppColors.darkGreen,
                  //         ),
                  //       );
                  //   },
                  //   // errorBuilder: (context, error, stackTrace) {
                  //   //   return const Padding(
                  //   //     padding: EdgeInsets.all(8.0),
                  //   //     child: CircularProgressIndicator(
                  //   //       color: AppColors.darkGreen,
                  //   //     ),
                  //   //   );
                  //   // },
                  // ),
                  child: CachedNetworkImage(
                    imageUrl: widget.product.image,
                    fit: BoxFit.cover,
                    height: 150,
                    width: double.infinity,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.darkGreenL,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                     BlocBuilder<ProductsCubit, ProductsState>(
                       builder: (context, state) {
                         if (state is ProductsLoadingState) {
                           return const Center(
                             child: CircularProgressIndicator(
                               color: AppColors.darkGreen,
                             ),
                           );// Show products
                         } else if (state is ProductsFailureState) {
                           return const Center(
                             child: Icon(Icons.error),
                           );
                         }
                         return const SizedBox.shrink();
                       },

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
                    widget.product.productName,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: getResponsiveSize(context, fontSize: 15),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    isPressed = !isPressed;
                    setState(() {});
                  },
                  icon: isPressed
                      ? Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: getResponsiveSize(context, fontSize: 20),
                  )
                      : Icon(
                    Icons.favorite_border,
                    size: getResponsiveSize(context, fontSize: 20),
                  ),
                ),
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
                    "${widget.product.price} EGP",
                    style: TextStyle(
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold,
                      fontSize: getResponsiveSize(context, fontSize: 15),
                    ),
                  ),
                ),
                Text(
                  "${widget.product.likesCounter} likes",
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
