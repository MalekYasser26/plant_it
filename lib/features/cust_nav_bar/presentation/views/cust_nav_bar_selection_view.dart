import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/cart/presentation/views/cart_view.dart';
import 'package:plant_it/features/cust_nav_bar/presentation/views/cust_nav_bar_view.dart';
import 'package:plant_it/features/favourites/presentation/views/favourites_view.dart';
import 'package:plant_it/features/home/presentation/views/home_view.dart';
import 'package:plant_it/features/profile/presentation/views/profile_view.dart';

class CustNavBarSelectionView extends StatefulWidget {
   int currentIndex ;

   CustNavBarSelectionView({super.key, required this.currentIndex});
  @override
  _CustNavBarSelectionViewState createState() => _CustNavBarSelectionViewState();
}

class _CustNavBarSelectionViewState extends State<CustNavBarSelectionView> {

  // Define the pages you want to navigate between


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.basicallyWhite,
      body: pages[widget.currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: widget.currentIndex,
        onTap: (index) {
          setState(() {
            widget.currentIndex = index;
          });
        },
      ),
    );
  }
}