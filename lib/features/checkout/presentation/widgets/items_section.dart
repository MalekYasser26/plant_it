import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:plant_it/features/cart/presentation/view_model/cart_item_model.dart';
import 'package:plant_it/features/checkout/presentation/widgets/checkout_item.dart';

class ItemsSection extends StatefulWidget {
  final List<CartItemModel> cartItems;
  const ItemsSection({
    super.key, required this.cartItems,
  });

  @override
  State<ItemsSection> createState() => _ItemsSectionState();
}

class _ItemsSectionState extends State<ItemsSection> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Items",
              style: TextStyle(
                fontFamily: "Raleway",
                fontWeight: FontWeight.bold,
                fontSize: getResponsiveSize(context, fontSize: 20),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 120, // Set a fixed height for the ListView
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return IntrinsicWidth(child: CheckoutItem(
                      index: index + 1,
                    name: widget.cartItems[index].name,
                    quantity: widget.cartItems[index].quantity,
                    price: widget.cartItems[index].price,
                    image: widget.cartItems[index].image,
                  ));
                },
                separatorBuilder: (context, index) =>
                const SizedBox(width: 10),
                itemCount: widget.cartItems.length,
              ),
            ),
          ],
        );
      },
    );
  }
}
