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
        appBar: const CustAppBar(
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
