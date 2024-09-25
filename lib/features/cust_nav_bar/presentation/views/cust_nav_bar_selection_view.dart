import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:plant_it/features/cust_nav_bar/presentation/views/cust_nav_bar_view.dart';
import 'package:plant_it/features/favourites/presentation/view_model/liked_plants_cubit.dart';
import 'package:plant_it/features/profile/presentation/view_model/profile_cubit.dart';

class CustNavBarSelectionView extends StatefulWidget {
   int currentIndex ;

   CustNavBarSelectionView({super.key, required this.currentIndex});
  @override
  _CustNavBarSelectionViewState createState() => _CustNavBarSelectionViewState();
}

class _CustNavBarSelectionViewState extends State<CustNavBarSelectionView> {



  @override
  Widget build(BuildContext context) {
    var lCubit = context.read<LikedPlantsCubit>();
    var sCubit = context.read<AuthCubit>();
    var pCubit = context.read<ProfileCubit>();
    return Scaffold(
      backgroundColor: AppColors.basicallyWhite,
      body: pages[widget.currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: widget.currentIndex,
        onTap: (index) {
          if (index ==2){
            lCubit.getRecentlyLikedProducts(sCubit.userID,false);
            lCubit.getProductSuggestions();

          }
          if (index ==0){
            pCubit.getRecentlySavedProducts(false);
          }
          setState(() {
            widget.currentIndex = index;
          });
        },
      ),
    );
  }
}