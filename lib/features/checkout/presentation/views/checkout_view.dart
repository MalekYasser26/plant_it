import 'package:flutter/material.dart';
import 'package:plant_it/features/cart/presentation/view_model/cart_item_model.dart';
import 'package:plant_it/features/checkout/presentation/widgets/checkout_view_body.dart';

class CheckoutView extends StatelessWidget {
  final List<CartItemModel> cartItems;
  final String totalPrice ;

  const CheckoutView({super.key, required this.cartItems, required this.totalPrice});
  @override
  Widget build(BuildContext context) {
    return  CheckoutViewBody(cartItems: cartItems,totalPrice: totalPrice,);
  }
}
