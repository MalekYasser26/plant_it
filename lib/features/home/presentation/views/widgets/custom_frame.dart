import 'dart:math';

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
  final Map<int, double> _imageHeights = {};
  @override
  Widget build(BuildContext context) {
    bool isNetworkImage = widget.product.image.startsWith('http');
    var lCubit = context.read<LikedCubit>();

    // We need to make sure only the frame related to this product is updated
    return BlocBuilder<LikedCubit, LikedState>(
      buildWhen: (previousState, currentState) {
        if (currentState is AddLikeSuccessState || currentState is RemoveLikeSuccessState) {
          // Only rebuild if the product in the state matches this product's ID
          return currentState.productID == widget.product.id;
        }
        return false; // No rebuild otherwise
      },
      builder: (context, state) {
        int currentLikeCounter = widget.product.likesCounter;
        if (state is AddLikeSuccessState && state.productID == widget.product.id) {
          currentLikeCounter = state.likeCounter;
        } else if (state is RemoveLikeSuccessState && state.productID == widget.product.id) {
          currentLikeCounter = state.likeCounter;
        }
        if (!_imageHeights.containsKey(widget.product.id)) {
          _imageHeights[widget.product.id] = (150.0 + Random().nextInt(51)).clamp(150, 200) as double;
        }
        double imageHeight = _imageHeights[widget.product.id]!;
        bool isLiked = lCubit.likedProducts.containsKey(widget.product.id);

        return Padding(
          padding:  EdgeInsets.only(top :imageHeight/28),
          child: Container(
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
                        builder: (context) =>
                            DescriptionView(product: widget.product,),
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
                          height: imageHeight,
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
                          widget.product.image,
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
                      IconButton(
                        onPressed: () {
                          if (!isLiked) {
                            lCubit.addLikedProducts(widget.product.id);
                          } else {
                            lCubit.removeLikedProducts(widget.product.id);
                          }
                        },
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : Colors.black,
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
                        "$currentLikeCounter likes",
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
          ),
        );
      },
    );
  }
}





