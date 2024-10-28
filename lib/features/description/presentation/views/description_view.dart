import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:plant_it/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:plant_it/features/checkout/presentation/widgets/cust_app_bar.dart';
import 'package:plant_it/features/cust_nav_bar/presentation/views/cust_nav_bar_selection_view.dart';
import 'package:plant_it/features/cust_nav_bar/presentation/views/cust_nav_bar_view.dart';
import 'package:plant_it/features/description/presentation/views/widgets/category_container.dart';
import 'package:plant_it/features/description/presentation/views/widgets/cust_rating_stars.dart';
import 'package:plant_it/features/description/presentation/views/widgets/description_section.dart';
import 'package:plant_it/features/description/presentation/views/widgets/plant_images_description.dart';
import 'package:plant_it/features/description/presentation/view_model/single_product_cubit.dart';
import 'package:plant_it/features/description/presentation/view_model/single_product.dart';
import 'package:plant_it/features/favourites/presentation/view_model/liked_cubit.dart';
import 'package:plant_it/features/home/presentation/view_model/home_product.dart';
import 'package:plant_it/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:plant_it/features/ratings_cubit/ratings_cubit.dart';

class DescriptionView extends StatefulWidget {
  final HomeProduct product;

  const DescriptionView({super.key, required this.product});

  @override
  State<DescriptionView> createState() => _DescriptionViewState();
}

class _DescriptionViewState extends State<DescriptionView> {
  bool isPressed = false;
  int quantity = 1;
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    // Fetch bookmarks and product data
    BlocProvider.of<SingleProductCubit>(context).fetchProductById(
        SingleProduct(
            id: widget.product.id,
            productName: '',
            price: '0',
            bio: '',
            availableStock: 0,
            likesCounter: 0,
            images: [],
            productCategories: []));
    BlocProvider.of<RatingsCubit>(context).getCurrentProductUserRating(
        widget.product.id
    );
  }

  @override
  Widget build(BuildContext context) {
    var lCubit = context.read<LikedCubit>();
    var sCubit = context.read<SingleProductCubit>();
    var pCubit = context.read<ProfileCubit>();
    var cCubit = context.read<CartCubit>();
    var aCubit = context.read<AuthCubit>();
    return BlocBuilder<SingleProductCubit, SingleProductState>(
      buildWhen: (previousState, currentState) {
        // Rebuild when the product is successfully loaded
        if (currentState is SingleProductSuccessfulState) {
          return true;
        }

        // Rebuild when bookmark is added or removed for this product
        if (currentState is AddBookmarkSuccessfulState ||
            currentState is RemoveBookmarkSuccessfulState) {
          return currentState.productID == widget.product.id;
        }

        // Rebuild when like is added or removed for this product
        if (currentState is AddLikeSuccessState ||
            currentState is RemoveLikeSuccessState) {
          return currentState.productID == widget.product.id;
        }

        return false;
      },
      builder: (context, state) {
        if (state is SingleProductSuccessfulState ||
            state is AddBookmarkSuccessfulState ||
            state is RemoveBookmarkSuccessfulState) {
          final SingleProduct product = state.product;
              pCubit.bookmarkedProducts.containsKey(widget.product.id);
          final List<String> productImages =
              product.images.map((image) => image.imgUrl).toList();
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.basicallyWhite,
              appBar: CustAppBar(
                text: product.productName, // Loaded product data
                implyLeading: true,
                methodNeededtoCall: () {
                  pCubit.getRecentlySavedProducts(true);
                  Navigator.pop(context);
                },
              ),
              body: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PlantImagesDescriptionWidget(
                            imageLinks: productImages,
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              const Text(
                                "EGP ",
                                style: TextStyle(
                                  fontFamily: "Raleway",
                                  fontSize: 25,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                product.price, // Loaded product data
                                style: const TextStyle(
                                  fontFamily: "Raleway",
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              BlocBuilder<LikedCubit, LikedState>(
                                buildWhen: (previousState, currentState) {
                                  if (currentState is AddLikeSuccessState ||
                                      currentState is RemoveLikeSuccessState) {
                                    return currentState.productID ==
                                        widget.product.id;
                                  }
                                  return false; // No rebuild otherwise
                                },
                                builder: (context, state) {
                                  bool isLiked = lCubit.likedProducts
                                      .containsKey(widget.product.id);

                                  return IconButton(
                                    onPressed: () {
                                      if (!isLiked) {
                                        lCubit.addLikedProducts(
                                            widget.product.id);
                                      } else {
                                        lCubit.removeLikedProducts(
                                            widget.product.id);
                                      }
                                    },
                                    icon: Icon(
                                      isLiked
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color:
                                          isLiked ? Colors.red : Colors.black,
                                      size: getResponsiveSize(context,
                                          fontSize: 20),
                                    ),
                                  );
                                },
                              ),
                              BlocBuilder<SingleProductCubit,
                                  SingleProductState>(
                                buildWhen: (previousState, currentState) {
                                  // Rebuild if there's a successful add/remove bookmark action
                                  return currentState
                                          is AddBookmarkSuccessfulState ||
                                      currentState
                                          is RemoveBookmarkSuccessfulState;
                                },
                                builder: (context, state) {
                                  return IconButton(
                                    onPressed: () {
                                      // Get the SingleProductCubit instance
                                      final sCubit =
                                          context.read<SingleProductCubit>();

                                      // Get the product's bookmark status from the cubit
                                      bool isBookmarked = sCubit
                                          .isBookmarked(widget.product.id,pCubit.bookmarkedProducts);

                                      // If it's not bookmarked, add it; otherwise, remove it
                                      if (!isBookmarked) {
                                        sCubit.addBookmarkedProducts(product,pCubit.bookmarkedProducts);
                                      } else {
                                        sCubit
                                            .removeBookmarkedProducts(product,pCubit.bookmarkedProducts);
                                      }
                                    },
                                    icon:
                                        !sCubit.isBookmarked(widget.product.id,pCubit.bookmarkedProducts)
                                            ? const Icon(Icons.bookmark_border,
                                                size: 25)
                                            : const Icon(Icons.bookmark_added,
                                                color: Colors.green, size: 25),
                                  );
                                },
                              ),
                            ],
                          ),
                          CustRatingStars(
                            productId: product.id,
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 40,
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 5),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  CategoryContainer(
                                      text: product
                                          .productCategories[index].name),
                              itemCount: product.productCategories.length,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const DescriptionSection(
                            title: "Description",
                            subfields: [
                              {
                                "header": "Appearance: ",
                                "description":
                                    "Monstera deliciosa is known for its large, heart-shaped leaves that develop splits and perforations as they mature."
                              },
                              {
                                "header": "Soil: ",
                                "description":
                                    "Use a well-draining potting mix, such as a peat-based mix with added perlite or orchid bark."
                              },
                              {
                                "header": "Growth Habit: ",
                                "description":
                                    "This plant is a climbing vine in its natural habitat, using aerial roots to anchor itself to trees."
                              },
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      BlocListener<CartCubit, CartState>(
                        listener: (context, state) {
                          if (state is AddCartItemSuccessfulState) {
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              // Show success message and navigate to the cart page
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                    "Added item Successfully",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  backgroundColor: AppColors.darkGreen,
                                ),
                              );
                              // Reset the state back to initial
                              context.read<CartCubit>().resetCartState();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CustNavBarSelectionView(currentIndex: 3),
                                ),
                              );
                            });
                          } else if (state is AddCartItemFailureState) {
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              // Show error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                    state.errorMsg,
                                    style: const TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              // Reset the state
                              context.read<CartCubit>().resetCartState();
                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDCDCDC),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: [
                                    InkWell(
                                      child: Icon(
                                        Icons.remove,
                                        size: getResponsiveSize(context, fontSize: 30),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          if (quantity > 1) quantity--;
                                        });
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                      child: Text(
                                        quantity.toString(),
                                        style: TextStyle(
                                          fontSize: getResponsiveSize(context, fontSize: 20),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      child: Icon(
                                        Icons.add,
                                        size: getResponsiveSize(context, fontSize: 30),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          quantity++;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20),
                              Flexible(
                                child: SizedBox(
                                  width: getResponsiveSize(context, fontSize: 350),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await cCubit.addCartItem(product.id, quantity);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFDCDCDC),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    ),
                                    child: Text(
                                      "Add to cart",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: getResponsiveSize(context, fontSize: 18),
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
        if (state is SingleProductFailureState) {
          return const SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.basicallyWhite,
              appBar: CustAppBar(
                text: "", // Loaded product data
                implyLeading: true,
              ),
              body: Center(
                child: Text(
                  'Failed to load product',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          );
        }
        return const SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.basicallyWhite,
            appBar: CustAppBar(
              text: "", // Loaded product data
              implyLeading: true,
            ),
            body: Center(
              child: CircularProgressIndicator(
                color: AppColors.darkGreen,
              ),
            ),
          ),
        );
      },
    );
  }
}
