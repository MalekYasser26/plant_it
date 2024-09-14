import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/profile/presentation/view_model/recently_saved_product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  // Method to update user profile
  Future<void> updateUser({
    required String address,
    required String phoneNumber,
    required String displayedName,
  }) async {
    emit(ProfileLoadingState()); // Emit loading state

    try {
      // Creating the body for the PUT request
      Map<String, String> requestBody = {
        "address": address,
        "phoneNumber": phoneNumber,
        "displayedName": displayedName,
      };

      // Sending the PUT request
      final response = await http.put(
        Uri.parse('$baseUrlHasoon/Authentication/UpdateUser'),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(requestBody),
      );

      // Checking the response status
      if (response.statusCode == 200) {
        emit(ProfileSuccessfulState()); // Emit success state
        print("User updated successfully: ${response.body}");
      } else {
        emit(ProfileFailureState()); // Emit failure state
        print("Failed to update user: ${response.statusCode}, ${response.body}");
      }
    } catch (error) {
      emit(ProfileFailureState()); // Emit failure state in case of error
      print("An error occurred: $error");
    }
  }

  Future<void> getRecentlySavedProducts() async {
    emit(RecentlySavedLoadingState());

    try {
      final response = await http.get(
        Uri.parse("$baseUrlHasoon/Bookmark/userBookMarks"),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body) as List<dynamic>;

        // Parse the response and map each product to RecentlySavedProductModel
        final List<RecentlySavedProductModel> savedProducts = responseBody
            .map((json) => RecentlySavedProductModel.fromJson(json))
            .toList();

        emit(RecentlySavedSuccessfulState(savedProducts));
      } else {
        emit(RecentlySavedFailureState());
        print("Failed to load saved products: ${response.statusCode}");
      }
    } catch (error) {
      emit(RecentlySavedFailureState());
      print("An error occurred: $error");
    }
  }


  Future<void> cacheProducts(List<RecentlySavedProductModel> products) async {
    final prefs = await SharedPreferences.getInstance();
    final String productsJson =
    json.encode(products.map((product) => product.toJson()).toList());
    await prefs.setString('cached_saved_products', productsJson);
    await prefs.setInt(
        'cache_time', DateTime.now().millisecondsSinceEpoch); // Store cache time
  }

  // Retrieve cached products from SharedPreferences
  Future<List<RecentlySavedProductModel>> getCachedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? productsJson = prefs.getString('cached_saved_products');
    final int? cacheTime = prefs.getInt('cache_time');

    // If cache is available and valid
    if (productsJson != null && cacheTime != null) {
      final int currentTime = DateTime.now().millisecondsSinceEpoch;
      const int cacheDuration = 60 * 60 * 1000; // Cache valid for 1 hour

      if (currentTime - cacheTime < cacheDuration) {
        // Parse the JSON and map it to List<RecentlySavedProductModel>
        final List<dynamic> productList = json.decode(productsJson);

        // Ensure the list is not null and return mapped product models
        return productList
            .map((json) => RecentlySavedProductModel.fromJson(json))
            .toList();
      }
    }

    // If no cache is available or it's expired, return an empty list
    return [];
  }
}