import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:plant_it/features/favourites/presentation/view_model/liked_cubit.dart';
import 'package:plant_it/features/home/presentation/view_model/home_product_cubit.dart';
final kInnerDecoration = BoxDecoration(
  color: Colors.white,
  border: Border.all(color: Colors.white),
  borderRadius: BorderRadius.circular(50),
);
final kGradientBoxDecoration = BoxDecoration(
  gradient: const LinearGradient(
    colors: [
      AppColors.darkGreen,
      AppColors.darkGreenL,
      AppColors.normGreen,
      AppColors.lightGreen,
      AppColors.lighterGreen,
      AppColors.barelyGreen,
    ],
  ),
  borderRadius: BorderRadius.circular(50),
);
class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {

  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var pCubit = context.read<HomeProductsCubit>();
    var lCubit = context.read<LikedCubit>();
    var sCubit = context.read<AuthCubit>();
    return Container(
      height: 50.0,
      decoration: kGradientBoxDecoration,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: kInnerDecoration,
          child: TextFormField(
            controller: searchController,
            keyboardType: TextInputType.emailAddress,
            onEditingComplete: () {
              pCubit.searchProducts(searchController.text,
              lCubit.getLikedProducts(
                sCubit.userID
              )
              );
              FocusScope.of(context).unfocus(); // Close the keyboard after search
            },
            onChanged: (value) {
              if (value==""){
                pCubit.fetchProducts(
                  lCubit.getLikedProducts(
                    sCubit.userID
                  )
                );
              }
            },
            onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
            decoration: InputDecoration(
              labelText: "Search for your plant here...",
              labelStyle: TextStyle(
                  fontFamily: "Raleway",
                  fontSize: getResponsiveSize(context, fontSize: 13),
                color: Colors.blueGrey
                  ),
              prefixIcon: const Icon(Icons.search,color: Colors.blueGrey,),
              border: InputBorder.none

            ),
          ),
        ),
      ),
    ) ;


  }
}
