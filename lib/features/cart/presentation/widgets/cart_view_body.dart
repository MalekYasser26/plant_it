import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/cart/presentation/widgets/cart_filled.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.basicallyWhite,
        appBar: AppBar(
          backgroundColor: AppColors.basicallyWhite,
          scrolledUnderElevation: 0.0,
          title: const Text(
            "Your cart",
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          centerTitle: true,
        ),
        body:  const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: CartFilled()
          ),
        ),
      ),
    );
  }
}


