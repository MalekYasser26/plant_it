import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:plant_it/features/cart/presentation/view_model/cart_item_model.dart';
import 'package:plant_it/features/checkout/presentation/view_model/checkout_cubit.dart';
import 'package:plant_it/features/checkout/presentation/widgets/address_info_section.dart';
import 'package:plant_it/features/checkout/presentation/widgets/items_section.dart';
import 'package:plant_it/features/checkout/presentation/widgets/cust_app_bar.dart';
import 'package:plant_it/features/checkout/presentation/widgets/order_summary.dart';
import 'package:plant_it/features/checkout/presentation/widgets/payment_method_section.dart';
import 'package:plant_it/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:plant_it/features/tracking/views/plants_ordered.dart';

class CheckoutViewBody extends StatefulWidget {
  final List<CartItemModel> cartItems;
  final String totalPrice;
  final String address , phoneNum ;

  const CheckoutViewBody(
      {super.key, required this.cartItems, required this.totalPrice, required this.address, required this.phoneNum});

  @override
  State<CheckoutViewBody> createState() => _CheckoutViewBodyState();
}

class _CheckoutViewBodyState extends State<CheckoutViewBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.basicallyWhite,
        appBar: const CustAppBar(
          text: "Checkout",
          implyLeading: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                       AddressInfoSection(
                        phoneNum: widget.phoneNum,
                         address: widget.address,
                      ),
                      const SizedBox(height: 10),
                      ItemsSection(
                        cartItems: widget.cartItems,
                      ),
                      const SizedBox(height: 10),
                      const PaymentMethodSection(),
                      const SizedBox(height: 10),
                      OrderSummary(totalPrice: widget.totalPrice),
                    ],
                  ),
                ),
                BlocListener<CheckoutCubit, CheckoutState>(
                  listener: (context, state) {
                    if (state is CheckoutSuccessfulState) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PlantsOrderedView(),
                        ),
                            (route) => false,
                      );
                    }

                    if (state is CheckoutDataIncompleteState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text("Go to the profile screen and complete your address & info first",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: Colors.red,
                          ),
                      );
                    }
                  },
                  child: BlocBuilder<CheckoutCubit, CheckoutState>(
                    builder: (context, state) {
                      if (state is CheckoutLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.darkGreenL,
                          ),
                        );
                      }

                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            var sCubit = context.read<AuthCubit>();
                            var chCubit = context.read<CheckoutCubit>();
                            var pCubit = context.read<ProfileCubit>();
                            chCubit.placeOrder(sCubit.userID);
                            pCubit.groupDatesByStatus();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.greyish,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          ),
                          child: Text(
                            "Place order",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: getResponsiveSize(context, fontSize: 18),
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
