import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:plant_it/features/cart/presentation/widgets/cart_empty.dart';
import 'package:plant_it/features/cart/presentation/widgets/cart_item.dart';
import 'package:plant_it/features/checkout/presentation/views/checkout_view.dart';

class CartFilled extends StatelessWidget {
  const CartFilled({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is UpdateCartFailureState) {
          // Show the SnackBar once when any item fails to update
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(
                state.errogMsg,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: AppColors.darkGreen,
            ),
          );
        }
      },
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<CartCubit, CartState>(
              buildWhen: (previous, current) {
                return current is CartSuccessfulStateFilled || current is CartLoadingState;
              },
              builder: (context, state) {
                if (state is CartSuccessfulStateFilled) {
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(top: 20),
                    itemBuilder: (context, index) => CartItem(
                      index: index + 1,
                      name: state.cartItems[index].name,
                      price: state.cartItems[index].price,
                      quantity: state.cartItems[index].quantity,
                      productID: state.cartItems[index].productID,
                    ),
                    separatorBuilder: (context, index) =>
                    const SizedBox(height: 30),
                    itemCount: state.cartItems.length,
                  );
                }
                return const CartEmpty();
              },
            ),
          ),
          Padding(
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
                              fontSize: getResponsiveSize(context, fontSize: 12),
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkGreenL),
                          children: [
                            TextSpan(
                              text: 'EGP',
                              style: TextStyle(
                                  fontFamily: "Raleway",
                                  fontSize:
                                  getResponsiveSize(context, fontSize: 12),
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                            ),
                            TextSpan(
                              text: ' 4470',
                              style: TextStyle(
                                  fontFamily: "Raleway",
                                  fontSize:
                                  getResponsiveSize(context, fontSize: 14),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CheckoutView(),
                          ),
                        );
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
                              fontSize: getResponsiveSize(context, fontSize: 18),
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
