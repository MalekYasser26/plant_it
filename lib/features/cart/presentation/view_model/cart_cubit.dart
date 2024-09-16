import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/cart/presentation/view_model/cart_item_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  Map<int, int> cartIDs = {};

  Future<void> getCartItems() async {
    emit(CartLoadingState());
    try {
      final response = await http.get(
        Uri.parse('$baseUrlHasoon/Cart/userCart'),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      final result = json.decode(response.body);
      if (result['message'] == "Cart is empty") {
        emit(CartSuccessfulStateEmpty());
      } else {
        final data = result['cart']['data'];
        List<CartItemModel> cartItems = [];

        for (var item in data) {
          cartItems.add(
            CartItemModel(
              name: item['product']['productName'],
              price: item['product']['price'],
              quantity: item['quantity'],
            ),
          );
          cartIDs[item['productId']] =
              item['id']; // Update your cartIDs map if needed
        }

        // Emit success state with the cart items
        emit(CartSuccessfulStateFilled(cartItems: cartItems));
      }
    } catch (e) {
      emit(CartFailureState()); // Handle error state
    }
  }


}
