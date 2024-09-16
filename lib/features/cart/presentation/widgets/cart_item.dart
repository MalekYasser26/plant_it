import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';

class CartItem extends StatefulWidget {
  final int index;
  final String name;

  final int quantity;

  final double price;

  const CartItem({
    super.key,
    required this.index,
    required this.name,
    required this.quantity,
    required this.price,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  bool isEditPressed = false  ;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
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
                              "${widget.quantity}x",
                              style: TextStyle(
                                fontFamily: "Raleway",
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    getResponsiveSize(context, fontSize: 16),
                              ),
                            ),
                            isEditPressed ?
                            Row(
                              children: [
                                Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.keyboard_double_arrow_up,
                                          color: AppColors.normGreen,
                                        )),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.keyboard_double_arrow_down,
                                          color: Colors.red,
                                        )),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      isEditPressed = !isEditPressed;
                                      setState(() {
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.check,
                                      color: AppColors.darkGreen,
                                    )),

                              ],
                            ) :
                            IconButton(
                                onPressed: () {
                                  isEditPressed = !isEditPressed;
                                  setState(() {
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
                    // const CustRatingStars(),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -15,
          // Adjust position to place the close button above the container
          right: 10,
          // Adjust position to align the close button correctly
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
