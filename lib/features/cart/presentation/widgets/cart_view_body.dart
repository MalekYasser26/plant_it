import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:plant_it/features/cart/presentation/widgets/cart_empty.dart';
import 'package:plant_it/features/cart/presentation/widgets/cart_filled.dart';
import 'package:plant_it/features/checkout/presentation/widgets/cust_app_bar.dart';

class CartViewBody extends StatefulWidget {
  const CartViewBody({super.key});

  @override
  State<CartViewBody> createState() => _CartViewBodyState();
}

class _CartViewBodyState extends State<CartViewBody> {
  void initState() {
    super.initState();
    context
        .read<CartCubit>()
        .getCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.basicallyWhite,
        appBar: CustAppBar(
          text: "Your cart",
          implyLeading: false,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: BlocBuilder<CartCubit, CartState>(
              buildWhen: (previous, current) {
                if (current is CartSuccessfulStateFilled) {
                  return true;
                }else {
                  return false ;
                }
              },
              builder: (context, state) {
                if (state is CartSuccessfulStateEmpty) {
                  return const CartEmpty();
                } else if (state is CartSuccessfulStateFilled) {
                  return const CartFilled();
                } else if (state is CartLoadingState) {
                  return const CircularProgressIndicator(
                    color: AppColors.darkGreenL,
                  );
                } else {
                  return const CartEmpty();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
