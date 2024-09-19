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
              productID: item['productId'],
              image : item['product']['productImage'] ?? "assets/images/placeholder.png"
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

  Future<void> updateCartItem(int productId, int quantity) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrlHasoon/Cart'),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken', // Pass your access token here
        },
        body: jsonEncode({
          'productId': productId,
          'quantity': quantity,
        }),
      );

      if (response.statusCode == 200) {
        emit(UpdateCartSuccessState());
        getCartItems();
      } else {
        emit(UpdateCartFailureState(json.decode(response.body)['message']));
      }
    } catch (e) {
      print(e.toString());
      emit(UpdateCartFailureState(e.toString()));
    }
  }

  Future<void> addCartItem(int productID, int quantity) async {
    emit(AddCartItemLoadingState());

    try {
      final response = await http.post(
        Uri.parse('$baseUrlHasoon/Cart'), // Corrected URL
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
          // Assuming accessToken is already defined
        },
        body: json.encode({
          'productId': productID,
          'quantity': quantity,
        }),
      );

      if (response.statusCode == 200) {
        if (json.decode(response.body)['succeeded'] == true) {
          emit(AddCartItemSuccessfulState());
        } else {
          emit(AddCartItemFailureState(json.decode(response.body)['message']));
        }
      } else {
        print('Failed to add cart item: ${response.statusCode}');
        emit(AddCartItemFailureState(json.decode(response.body)[
            'message'])); // Emit failure state if response is not OK
      }
    } catch (e) {
      print('Error occurred: $e');
      emit(AddCartItemFailureState(
          e.toString())); // Handle error state for exceptions
    }
  }

  Future<void> removeCartItem(int productID) async {
    emit(RemoveCartItemLoadingState());

    try {
      // Get the cartID from the productID
      int? cartID = cartIDs[productID];

      if (cartID == null) {
        emit(RemoveCartItemFailureState(
            "Cart ID not found for the given product."));
        return;
      }

      final response = await http.delete(
        Uri.parse('$baseUrlHasoon/Cart?cartId=$cartID'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $accessToken',
          // Assuming accessToken is already defined
        },
      );

      if (response.statusCode == 200) {
        if (json.decode(response.body)['succeeded'] == true) {
          emit(RemoveCartItemSuccessfulState(productID));
        } else {
          emit(RemoveCartItemFailureState(
              json.decode(response.body)['message']));
        }
      } else {
        emit(RemoveCartItemFailureState(json.decode(response.body)['message']));
      }
    } catch (e) {
      emit(RemoveCartItemFailureState(e.toString()));
    }
  }

  void resetCartState() async {
    emit(CartInitial());
  }

  Future<void> checkAvailability() async {
    emit(CheckAvailabilityLoadingState());
    try {
      final response = await http.get(
        Uri.parse('$baseUrlHasoon/Cart/CheckAvailable'),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      final result = json.decode(response.body);
      print(result['succeeded']);
      if (result['succeeded'] == true) {
        emit(CheckAvailabilitySuccessfulState());
      } else if (result['succeeded'] == false) {
        emit(CheckAvailabilityFailureState(
          result['data']['productName'],
          result['data']['availableStock'],
        ));
      }
    } catch (e) {
      emit(CheckAvailabilityFailureState(e.toString(),0)); // Handle error state
    }
  }
}
