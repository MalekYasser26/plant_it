import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:plant_it/features/cart/presentation/view_model/cart_item_model.dart';
import 'package:plant_it/features/cart/presentation/widgets/cart_empty.dart';
import 'package:plant_it/features/cart/presentation/widgets/cart_item.dart';
import 'package:plant_it/features/checkout/presentation/views/checkout_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartFilled extends StatefulWidget {
  const CartFilled({super.key});

  @override
  State<CartFilled> createState() => _CartFilledState();
}

class _CartFilledState extends State<CartFilled> {
  List<CartItemModel> cartItems = [];
  double totalPrice = 0.0;
  bool hasShownSnackBar = false; // Flag to ensure SnackBar shows only once

  // A method to calculate the total price
  void calculateTotalPrice() {
    totalPrice = 0.0; // Reset total price before calculating
    for (var item in cartItems) {
      totalPrice += item.price * item.quantity;
    }
  }

  @override
  Widget build(BuildContext context) {
    var cCubit = context.read<CartCubit>();
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is UpdateCartFailureState) {
          // Show the SnackBar when any item fails to update
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(
                state.errogMsg,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: AppColors.darkGreen,
            ),
          );
        }

        if (state is RemoveCartItemSuccessfulState) {
          setState(() {
            cartItems.removeWhere((item) => item.productID == state.productID);
            calculateTotalPrice(); // Recalculate total price after removal
          });
        }
      },
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<CartCubit, CartState>(
              buildWhen: (previous, current) {
                return current is CartSuccessfulStateFilled ||
                    current is CartLoadingState;
              },
              builder: (context, state) {
                if (state is CartSuccessfulStateFilled) {
                  cartItems = state.cartItems;
                  calculateTotalPrice(); // Calculate total price after cart items are loaded
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(top: 20),
                    itemBuilder: (context, index) => CartItem(
                      index: index + 1,
                      name: cartItems[index].name,
                      price: cartItems[index].price,
                      quantity: cartItems[index].quantity,
                      productID: cartItems[index].productID,
                      image: cartItems[index].image,
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 30),
                    itemCount: cartItems.length,
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
                BlocBuilder<CartCubit, CartState>(
                  buildWhen: (previous, current) {
                    return current is CartSuccessfulStateFilled;
                  },
                  builder: (context, setState) => Container(
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
                              fontSize:
                                  getResponsiveSize(context, fontSize: 12),
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkGreenL,
                            ),
                            children: [
                              TextSpan(
                                text: 'EGP',
                                style: TextStyle(
                                  fontFamily: "Raleway",
                                  fontSize:
                                      getResponsiveSize(context, fontSize: 12),
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: ' $totalPrice',
                                // Use totalPrice here, after it is calculated
                                style: TextStyle(
                                  fontFamily: "Raleway",
                                  fontSize:
                                      getResponsiveSize(context, fontSize: 14),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                BlocListener<CartCubit, CartState>(
                  listener: (context, state) async {
                    final prefs = await SharedPreferences.getInstance();
                    if (state is CheckAvailabilitySuccessfulState) {
                      if (context.mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutView(
                              cartItems: cartItems,
                              totalPrice: totalPrice.toString(),
                              address: prefs.getString("address")!,
                              phoneNum: prefs.getString("phoneNum")!,
                            ),
                          ),
                        );
                      }
                    }
                    if (state is CheckAvailabilityFailureState &&
                        !hasShownSnackBar &&
                        context.mounted) {
                      // Show SnackBar once
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            "${state.name} has ${state.quantity} left only",
                            style: const TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      hasShownSnackBar = true; // Set flag to true after showing
                      context.read<CartCubit>().resetCartState();
                    }
                  },
                  child: BlocListener<CartCubit, CartState>(
                    listener: (context, state) {

                    },
                    child: BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        return Flexible(
                          child: SizedBox(
                              width: getResponsiveSize(context, fontSize: 350),
                              height: getResponsiveSize(context, fontSize: 55),
                              child: !cCubit.isEditPressed ?
                              ElevatedButton(
                                onPressed: () {
                                  hasShownSnackBar =
                                      false; // Reset flag before checking
                                  context.read<CartCubit>().checkAvailability();
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => const PlantsOrderedView(),));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFDCDCDC),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                ),
                                child: Text(
                                  "Checkout",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: getResponsiveSize(context,
                                        fontSize: 18),
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ) :ElevatedButton(
                                onPressed: () {
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFDCDCDC),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                ),
                                child: Text(
                                  "Checkout",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: getResponsiveSize(context,
                                        fontSize: 18),
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ) ),
                        );
                      },
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
