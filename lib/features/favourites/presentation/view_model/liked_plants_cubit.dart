import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/favourites/presentation/view_model/recently_liked_products.dart';
import 'package:http/http.dart' as http ;
import 'package:shared_preferences/shared_preferences.dart';
part 'liked_plants_state.dart';

class LikedPlantsCubit extends Cubit<LikedPlantsState> {
  LikedPlantsCubit() : super(LikedPlantsInitial());
  int totalItems =0;
  Future<void> getRecentlyLikedProducts(int userID) async {
    emit(RecentlyLikedLoadingState());
    try {
      final response = await http.get(
        Uri.parse("$baseUrlHasoon/Likes/userId?userId=$userID"),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final List<dynamic> productJson = responseBody['data']; // Access the 'data' field

        // Map each item in the 'data' list to a RecentlySavedProductModel
        final List<RecentlyLikedProductModel> products = productJson
            .map((json) => RecentlyLikedProductModel.fromJson(json))
            .toList();
        final List<RecentlyLikedProductModel> lastTwoProducts = [];
        await cacheProducts(products);
        totalItems = products.length;
        emit(RecentlyLikedSuccessfulState(totalItems,products));
      } else {
        // Handle non-200 status codes
        emit(RecentlyLikedFailureState());
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(RecentlyLikedFailureState());
    }
  }

  Future<void> cacheProducts(List<RecentlyLikedProductModel> products) async {
    final prefs = await SharedPreferences.getInstance();
    final String productsJson =
    json.encode(products.map((product) => product.toJson()).toList());
    await prefs.setString('cached_saved_products', productsJson);
    await prefs.setInt('cache_time',
        DateTime.now().millisecondsSinceEpoch); // Store cache time
  }

  Future<List<RecentlyLikedProductModel>> getCachedProducts() async {
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
        return productList.map((json) => RecentlyLikedProductModel.fromJson(json)).toList();
      }
    }

    // If no cache is available or it's expired, return an empty list
    return [];
  }
}
