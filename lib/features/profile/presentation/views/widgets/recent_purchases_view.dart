import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/checkout/presentation/widgets/cust_app_bar.dart';
import 'package:plant_it/features/home/presentation/view_model/home_product.dart';
import 'package:plant_it/features/home/presentation/view_model/home_product_cubit.dart';
import 'package:plant_it/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:plant_it/features/profile/presentation/views/widgets/recent_purchased_frame.dart';
import 'package:plant_it/features/ratings_cubit/ratings_cubit.dart';

class RecentPurchasesView extends StatelessWidget {
  const RecentPurchasesView({super.key});

  @override
  Widget build(BuildContext context) {
    var hCubit = context.read<HomeProductsCubit>();
    var pCubit = context.read<ProfileCubit>();
    var rCubit = context.read<RatingsCubit>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.basicallyWhite,
        appBar: CustAppBar(
          text: "Recent purchases",
          implyLeading: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                List<HomeProduct> products = [];
                List<double> productRatings = [];
                for (var item in hCubit.cachedProducts) {
                  if (pCubit.purchasedProductIDs.contains(item.id)) {
                    products.add(item);
                  }
                }
                for (var entry in rCubit.cachedRatings.entries) {
                  int productId = entry.key;
                  double rating = entry.value;
                  if (pCubit.purchasedProductIDs.contains(productId)) {
                    productRatings.add(rating);
                    print('here');
                  }
                }
                return Column(
                  children: [
                    BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        return Expanded(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(top: 20),
                            itemBuilder: (context, index) =>
                                RecentPurchasedFrame(
                                  imagePath: products[index].image,
                                  price: products[index].price,
                                  productName: products[index].productName,
                                  rating: productRatings[index],
                                  id: products[index].id,

                                ),
                            separatorBuilder: (context, index) =>
                            const SizedBox(height: 30),
                            itemCount: products.length,
                          ),
                        );
                      },
                    ),
                    products.isEmpty ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Container(
                            height: getResponsiveSize(context, fontSize: 55),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDCDCDC),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Order total\n ',
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: getResponsiveSize(context,
                                            fontSize: 12),
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.darkGreenL),
                                    // Default text color
                                    children: [
                                      TextSpan(
                                        text: 'EGP',
                                        style: TextStyle(
                                            fontFamily: "Raleway",
                                            fontSize: getResponsiveSize(context,
                                                fontSize: 12),
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black),
                                        // Color for "Sign in"
                                      ),
                                      TextSpan(
                                        text: ' 4470',
                                        style: TextStyle(
                                            fontFamily: "Raleway",
                                            fontSize: getResponsiveSize(context,
                                                fontSize: 14),
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        // Color for "Sign in"
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: SizedBox(
                              width: getResponsiveSize(context, fontSize: 350),
                              height: getResponsiveSize(context, fontSize: 55),
                              child: ElevatedButton(
                                onPressed: () {
                                  print("checkout");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFDCDCDC),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                ),
                                child: Text("Checkout",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: getResponsiveSize(context,
                                            fontSize: 18),
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ) :const SizedBox.shrink()
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
