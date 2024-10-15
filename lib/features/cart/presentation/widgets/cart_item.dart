import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/cart/presentation/view_model/cart_cubit.dart';

class CartItem extends StatefulWidget {
  final int index, productID;
  final String name, image;
  final int quantity;
  final double price;

  const CartItem({
    super.key,
    required this.index,
    required this.name,
    required this.quantity,
    required this.price,
    required this.productID,
    required this.image,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late int quantityEdit;
  bool isEditPressed = false;  // Local state to track if the item is being edited
  bool quantityReverted = false;

  @override
  void initState() {
    super.initState();
    quantityEdit = widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    var cCubit = context.read<CartCubit>();
    return Stack(
      clipBehavior: Clip.none,
      children: [
        BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is UpdateCartFailureState && !quantityReverted) {
              // Revert quantity to original when the update fails, but only once
              quantityEdit = widget.quantity;
              quantityReverted = true; // Prevent multiple resets
            }

            if (state is UpdateCartSuccessState) {
              // Reset the reverted flag after a successful update
              quantityReverted = false;
            }

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
                      child: widget.image.startsWith('http')
                          ? CachedNetworkImage(
                        imageUrl: widget.image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorWidget: (context, url, error) {
                          return Image.asset(
                            'assets/images/placeholder.png',
                            fit: BoxFit.cover,
                            height: 150,
                            width: double.infinity,
                          );
                        },
                        fadeInDuration: const Duration(milliseconds: 500),
                        fadeOutDuration:
                        const Duration(milliseconds: 500),
                      )
                          : Image.asset(
                        widget.image,
                        fit: BoxFit.cover,
                        width: double.infinity,
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
                                isEditPressed
                                    ? Text(
                                  "${quantityEdit}x",
                                  style: TextStyle(
                                    fontFamily: "Raleway",
                                    fontWeight: FontWeight.bold,
                                    fontSize: getResponsiveSize(context,
                                        fontSize: 16),
                                  ),
                                )
                                    : Text(
                                  "${widget.quantity}x",
                                  style: TextStyle(
                                    fontFamily: "Raleway",
                                    fontWeight: FontWeight.bold,
                                    fontSize: getResponsiveSize(context,
                                        fontSize: 16),
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
                                              quantityEdit++; // Increment the quantity
                                            });
                                          },
                                          icon: const Icon(
                                            Icons
                                                .keyboard_double_arrow_up,
                                            color: AppColors.normGreen,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if (quantityEdit > 1) {
                                                quantityEdit--; // Decrement but not below 1
                                              }
                                            });
                                          },
                                          icon: const Icon(
                                            Icons
                                                .keyboard_double_arrow_down,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        print(cCubit.isEditPressed);
                                        if (cCubit.isEditPressed==true) {
                                          cCubit.updateCartItem(
                                            widget.productID,
                                            quantityEdit,
                                          );
                                          setState(() {
                                            isEditPressed = false;
                                            cCubit.isEditPressed = false;
                                          });
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.check,
                                        color: AppColors.darkGreen,
                                      ),
                                    ),
                                  ],
                                )
                                    : IconButton(
                                  onPressed: () {
                                    print(cCubit.isEditPressed);
                                    if (cCubit.isEditPressed==false) {
                                      cCubit.changeState();
                                      setState(() {
                                        isEditPressed =
                                        true; // Enter edit mode for this item
                                        cCubit.isEditPressed = true;
                                      });
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: AppColors.greyish,
                                  ),
                                ),
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
                                isEditPressed
                                    ? Text(
                                  "${widget.price * quantityEdit} ",
                                  style: const TextStyle(
                                    fontFamily: "Raleway",
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                                    : Text(
                                  "${widget.price * widget.quantity} ",
                                  style: const TextStyle(
                                    fontFamily: "Raleway",
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
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
              cCubit.removeCartItem(widget.productID);
            },
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.greyish),
              ),
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
