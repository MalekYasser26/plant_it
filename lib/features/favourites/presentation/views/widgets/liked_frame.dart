import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/description/presentation/views/description_view.dart';
import 'package:plant_it/features/favourites/presentation/view_model/liked_cubit.dart';
import 'package:plant_it/features/favourites/presentation/view_model/liked_plants_cubit.dart';
import 'package:plant_it/features/home/presentation/view_model/home_product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LikedFrame extends StatefulWidget {
  final String imagePath, productName;

  final String price;

  final int likeCounter;

  final int id;

  const LikedFrame(
      {super.key,
      required this.imagePath,
      required this.productName,
      required this.price,
      required this.likeCounter,
      required this.id});

  @override
  State<LikedFrame> createState() => _LikedFrameState();
}

class _LikedFrameState extends State<LikedFrame> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    HomeProduct p = HomeProduct(
        id: widget.id, productName: "", price: '', likesCounter: -2, image: '');

    return BlocBuilder<LikedCubit, LikedState>(
      buildWhen: (previousState, currentState) {
        if (currentState is AddLikeSuccessState || currentState is RemoveLikeSuccessState) {
          // Only rebuild if the product in the state matches this product's ID
          return currentState.productID == widget.id;
        }
        return false; // No rebuild otherwise
      },

      builder: (context, state) {
        var lCubit = context.read<LikedCubit>();
        var lpCubit = context.read<LikedPlantsCubit>();
        bool isLiked = lCubit.likedProducts.containsKey(widget.id);

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
                      builder: (context) => DescriptionView(
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
                        child: widget.imagePath.startsWith('http')
                            ? CachedNetworkImage(
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
                                fadeInDuration:
                                    const Duration(milliseconds: 500),
                                fadeOutDuration:
                                    const Duration(milliseconds: 500),
                              )
                            : Image.asset(
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
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          print("here :! ${prefs.getInt('userID')}");
                          if (!isLiked) {
                            await lCubit.addLikedProducts(widget.id);
                          } else {
                            await lCubit.removeLikedProducts(widget.id);
                          }
                          await lpCubit.getRecentlyLikedProducts(
                              prefs.getInt('userID')!, true);
                        },
                        child: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : Colors.black,
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
      },
    );
  }
}
