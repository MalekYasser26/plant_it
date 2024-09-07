import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
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
  Widget build(BuildContext context) {
    var lCubit = context.read<LikedCubit>();

    return BlocProvider(
      create: (_) {
        return SingleProductCubit()..fetchProductById(widget.product.id);
      },
      child: BlocBuilder<SingleProductCubit, SingleProductState>(
        builder: (context, state) {
          if (state is SingleProductLoadingState) {
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
          }
          if (state is SingleProductSuccessfulState) {
            final SingleProduct product = state.product;

            // Extract image URLs from the product's images
            final List<String> productImages =
                product.images.map((image) => image.imgUrl).toList();
            return SafeArea(
              child: Scaffold(
                backgroundColor: AppColors.basicallyWhite,
                appBar: CustAppBar(
                  text: product.productName, // Loaded product data
                  implyLeading: true,
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
                                    if (currentState is AddLikeSuccessState || currentState is RemoveLikeSuccessState) {
                                      // Only rebuild if the product in the state matches this product's ID
                                      return currentState.productID == widget.product.id;
                                    }
                                    return false; // No rebuild otherwise
                                  },

                                  builder: (context, state) {
                                    bool isLiked = lCubit.likedProducts.containsKey(widget.product.id);

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
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isPressed = !isPressed;
                                    });
                                  },
                                  icon: isPressed
                                      ? const Icon(
                                          Icons.bookmark_added,
                                          color: Colors.green,
                                          size: 25,
                                        )
                                      : const Icon(
                                          Icons.bookmark_border,
                                          size: 25,
                                        ),
                                ),
                              ],
                            ),
                            const CustRatingStars(),
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
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDCDCDC),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                InkWell(
                                  child: Icon(
                                    Icons.remove,
                                    size: getResponsiveSize(context,
                                        fontSize: 15),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      if (quantity > 1) quantity--;
                                    });
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Text(
                                    quantity.toString(),
                                    style: TextStyle(
                                      fontSize: getResponsiveSize(context,
                                          fontSize: 20),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  child: Icon(
                                    Icons.add,
                                    size: getResponsiveSize(context,
                                        fontSize: 15),
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
                                onPressed: () {
                                  print("add to cart");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CustNavBarSelectionView(
                                              currentIndex: 3),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFDCDCDC),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                ),
                                child: Text(
                                  "Add to cart",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: getResponsiveSize(context,
                                        fontSize: 18),
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
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomBottomNavBar(
                        currentIndex: 1,
                        onTap: (index) {
                          setState(() {
                            _currentIndex = index;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CustNavBarSelectionView(
                                  currentIndex: _currentIndex,
                                ),
                              ),
                            );
                          });
                        },
                      ),
                    ),
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
      ),
    );
  }
}
