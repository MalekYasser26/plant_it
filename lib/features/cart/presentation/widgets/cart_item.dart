import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/cart/presentation/view_model/cart_cubit.dart';

class CartItem extends StatefulWidget {
  final int index,productID;
  final String name;

  final int quantity;

  final double price;

  const CartItem({
    super.key,
    required this.index,
    required this.name,
    required this.quantity,
    required this.price, required this.productID,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  bool isEditPressed = false;
  late int quantityEdit;  // Make this a member variable to persist across rebuilds

  @override
  void initState() {
    super.initState();
    quantityEdit = widget.quantity;  // Initialize it in initState
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xFFF8F9EF),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    height: 90,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/images/plant${widget.index}.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: getResponsiveSize(context, fontSize: 19),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${quantityEdit}x", // Use the updated quantityEdit
                                  style: TextStyle(
                                    fontFamily: "Raleway",
                                    fontWeight: FontWeight.bold,
                                    fontSize: getResponsiveSize(context, fontSize: 16),
                                  ),
                                ),
                                isEditPressed
                                    ? Row(
                                  children: [
                                    Column(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                quantityEdit++; // Update the quantity
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.keyboard_double_arrow_up,
                                              color: AppColors.normGreen,
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (quantityEdit > 1) {
                                                  quantityEdit--; // Prevent decrement below 1
                                                }
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.keyboard_double_arrow_down,
                                              color: Colors.red,
                                            )),
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          context.read<CartCubit>().updateCartItem(widget.productID, quantityEdit);
                                          setState(() {
                                            isEditPressed = !isEditPressed;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.check,
                                          color: AppColors.darkGreen,
                                        )),
                                  ],
                                )
                                    : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isEditPressed = !isEditPressed;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: AppColors.greyish,
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "EGP ",
                                  style: TextStyle(
                                    fontFamily: "Raleway",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(
                                  "${widget.price} ",
                                  style: const TextStyle(
                                    fontFamily: "Raleway",
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Positioned(
          top: -15,
          right: 10,
          child: GestureDetector(
            onTap: () {
              print("Close button tapped");
            },
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.greyish)),
              child: Icon(
                Icons.close,
                size: getResponsiveSize(context, fontSize: 25),
                color: Colors.black54,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
