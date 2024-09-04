import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/features/favourites/presentation/view_model/liked_cubit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/description/presentation/views/description_view.dart';
import 'package:plant_it/features/home/presentation/view_model/home_product.dart';

class CustomFrame extends StatefulWidget {
  final HomeProduct product;
  final int index;

  const CustomFrame({super.key, required this.product, required this.index});

  @override
  State<CustomFrame> createState() => _CustomFrameState();
}

class _CustomFrameState extends State<CustomFrame> {

  @override
  Widget build(BuildContext context) {
    bool isNetworkImage = widget.product.image.startsWith('http'); // Check if the image is a URL or a local asset
    var lCubit = context.read<LikedCubit>();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DescriptionView(productId: widget.product.id),
                ),
              );
            },
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
                  child: isNetworkImage
                      ? CachedNetworkImage(
                    imageUrl: widget.product.image,
                    fit: BoxFit.cover,
                    height: 150,
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
                        'assets/images/plant6.png',
                        fit: BoxFit.cover,
                        height: 150,
                        width: double.infinity,
                      );
                    },
                    fadeInDuration: const Duration(milliseconds: 500),
                    fadeOutDuration: const Duration(milliseconds: 500),
                  )
                      : Image.asset(
                    widget.product.image, // Load the local image if it's an asset
                    fit: BoxFit.cover,
                    height: 150,
                    width: double.infinity,
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
                BlocBuilder<LikedCubit, LikedState>(
                  builder: (context, state) {
                    bool isLiked = lCubit.likedProductIds.contains(widget.product.id);
                    return IconButton(
                      onPressed: () {
                        if (!isLiked) {
                          lCubit.addLikedProducts(widget.product.id);
                        } else {
                          // You can add a remove like function here if needed.
                        }
                      },
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : Colors.black,
                        size: getResponsiveSize(context, fontSize: 20),
                      ),
                    );
                  },
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




