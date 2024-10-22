import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/home/presentation/view_model/home_product.dart';
import 'package:plant_it/features/home/presentation/view_model/home_product_cubit.dart';
import 'package:plant_it/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:plant_it/features/profile/presentation/views/widgets/recent_purchased_frame.dart';
import 'package:plant_it/features/profile/presentation/views/widgets/recent_purchases_view.dart';
import 'package:plant_it/features/ratings_cubit/ratings_cubit.dart';

class RecentPurchasesSection extends StatefulWidget {
  const RecentPurchasesSection({
    super.key,
  });

  @override
  State<RecentPurchasesSection> createState() => _RecentPurchasesSectionState();
}

class _RecentPurchasesSectionState extends State<RecentPurchasesSection> {
  @override
  Widget build(BuildContext context) {
    var hCubit = context.read<HomeProductsCubit>();
    var pCubit = context.read<ProfileCubit>();
    var rCubit = context.read<RatingsCubit>();
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent purchases",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: getResponsiveSize(context, fontSize: 20),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RecentPurchasesView(),
                      ));
                },
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColors.greyish),
                ),
                child: Text(
                  "Show all",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w300,
                    fontSize: getResponsiveSize(context, fontSize: 15),
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              List<HomeProduct> products = [];
              List<double> productRatings = [];
              for (var item in hCubit.cachedProducts){
                if (pCubit.purchasedProductIDs.contains(item.id)){
                  products.add(item);
                }
              }
              for (var item in rCubit.cachedRatings.entries){
                if (pCubit.purchasedProductIDs.contains(item.key)){
                  productRatings.add(item.value);
                }
              }
              if (products.isNotEmpty) {
                return Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        RecentPurchasedFrame(
                          imagePath: products[index].image,
                          price: products[index].price,
                          productName: products[index].productName,
                          rating: productRatings[index],
                          id: products[index].id,
                        ),
                    separatorBuilder: (context, index) =>
                    const SizedBox(
                      height: 12,
                    ),
                    itemCount: products.length.clamp(0, 3),
                  ),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/cartEmpty.png",
                      height: 200,
                      width: 150,
                    ),
                    const SizedBox(height: 15,),
                    Text("No purchases found",style: TextStyle(
                        fontFamily: "Poor Story",
                        fontSize: getResponsiveSize(context, fontSize: 30),
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFFADABAB)
                    ),)
                  ],
                );
              }
            },
          )
        ],
      ),
    );
  }
}
