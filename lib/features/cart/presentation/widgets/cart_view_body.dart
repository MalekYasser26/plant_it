import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:plant_it/features/cart/presentation/widgets/cart_empty.dart';
import 'package:plant_it/features/cart/presentation/widgets/cart_filled.dart';
import 'package:plant_it/features/checkout/presentation/widgets/cust_app_bar.dart';
import 'package:plant_it/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:plant_it/features/tracking/views/order_tracker_selection.dart';

class CartViewBody extends StatefulWidget {
  const CartViewBody({super.key});

  @override
  State<CartViewBody> createState() => _CartViewBodyState();
}

class _CartViewBodyState extends State<CartViewBody> {
  @override
  void initState() {
    super.initState();
    context
        .read<CartCubit>()
        .getCartItems();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children:[
          Scaffold(
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
          Positioned(
            right: 0,
            top: 5,
            child: IconButton(onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => const OrderTrackerSelection(),) );
            }, icon: const Icon(Icons.local_shipping_outlined,size: 30,color: AppColors.normGreen,)),
          ),

        ]
      ),
    );
  }
}
