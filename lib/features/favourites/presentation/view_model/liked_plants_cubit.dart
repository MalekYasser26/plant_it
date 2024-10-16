import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/favourites/presentation/view_model/product_suggestion_model.dart';
import 'package:plant_it/features/favourites/presentation/view_model/recently_liked_products.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'liked_plants_state.dart';

class LikedPlantsCubit extends Cubit<LikedPlantsState> {
  LikedPlantsCubit() : super(LikedPlantsInitial());
  int totalItems = 0;
  List<RecentlyLikedProductModel> cachedProducts = [];
  List<ProductSuggestionModel> productSuggestions = [];

  Future<void> getRecentlyLikedProducts(int userID, bool called) async {
    emit(RecentlyLikedLoadingState());
    final prefs = await SharedPreferences.getInstance();
    if (cachedProducts.isNotEmpty && called == false) {
      totalItems = cachedProducts.length;
      emit(LikedSuggestedPlantsCombinedState(
          productSuggestions: productSuggestions,
          recentlyLikedProducts: cachedProducts,
          totalItems: totalItems));
    } else {
      try {
        final response = await http.get(
          Uri.parse("$baseUrlHasoon/Likes/userId?userId=$userID"),
          headers: {
            'accept': '*/*',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${prefs.getString("accessToken")}',
          },
        );
        if (response.statusCode == 200) {

          final responseBody = json.decode(response.body);
          final List<dynamic> productJson =
              responseBody['data']; // Access the 'data' field
          cachedProducts = productJson
              .map((json) => RecentlyLikedProductModel.fromJson(json))
              .toList();
          await cacheProducts(cachedProducts);
          totalItems = cachedProducts.length;
          emit(LikedSuggestedPlantsCombinedState(
              productSuggestions: productSuggestions,
              recentlyLikedProducts: cachedProducts,
              totalItems: totalItems));
        } else {
          // Handle non-200 status codes
          emit(RecentlyLikedFailureState());
        }
      } catch (e) {
        debugPrint(e.toString());
        emit(RecentlyLikedFailureState());
      }
    }
  }

  Future<void> getProductSuggestions(bool called) async {
    emit(SuggestedProductLoadingState());
    final prefs = await SharedPreferences.getInstance();

    if (productSuggestions.isNotEmpty && called == false) {
      print("I am here ");
      emit(LikedSuggestedPlantsCombinedState(
          productSuggestions: productSuggestions,
          recentlyLikedProducts: cachedProducts,
          totalItems: totalItems));
    } else {
      try {
        final response = await http.get(
          Uri.parse(
              "https://plantitapi.runasp.net/api/Product/SuggestedProducts"),
          headers: {
            'accept': '*/*',
            'Authorization': 'Bearer ${prefs.getString("accessToken")}',
          },
        );
        if (response.statusCode == 200) {
          final responseBody = json.decode(response.body);
          final List<dynamic> productJson = responseBody['data'];

          // Safely map the JSON response to a list of ProductSuggestionModel instances
          productSuggestions = productJson
              .map((json) => ProductSuggestionModel.fromJson(json))
              .toList();

          // Cache the product suggestions
          await cacheProductSuggestions(productSuggestions);

          // Emit the success state with the product suggestions
          emit(LikedSuggestedPlantsCombinedState(
              productSuggestions: productSuggestions,
              recentlyLikedProducts: cachedProducts,
              totalItems: totalItems));
        } else {
          print(" I am really here ");
          print(response.statusCode);
          print(productSuggestions);
          emit(SuggestedProductFailureState());
        }
      } catch (e) {
        debugPrint("Error fetching product suggestions: $e");
        emit(SuggestedProductFailureState());
      }
    }
  }

  Future<void> cacheProductSuggestions(
      List<ProductSuggestionModel> products) async {
    final prefs = await SharedPreferences.getInstance();
    final String productsJson =
        json.encode(products.map((product) => product.toJson()).toList());
    await prefs.setString('cached_product_suggestions', productsJson);
    await prefs.setInt(
        'cache_suggestions_time', DateTime.now().millisecondsSinceEpoch);
  }

  Future<List<ProductSuggestionModel>> getCachedProductSuggestions() async {
    final prefs = await SharedPreferences.getInstance();
    final String? productsJson = prefs.getString('cached_product_suggestions');
    final int? cacheTime = prefs.getInt('cache_suggestions_time');

    // If cache is available and valid
    if (productsJson != null && cacheTime != null) {
      final int currentTime = DateTime.now().millisecondsSinceEpoch;
      const int cacheDuration = 60 * 60 * 1000; // Cache valid for 1 hour

      if (currentTime - cacheTime < cacheDuration) {
        final List<dynamic> productList = json.decode(productsJson);
        return productList
            .map((json) => ProductSuggestionModel.fromJson(json))
            .toList();
      }
    }

    // Return an empty list if cache is expired or unavailable
    return [];
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
        return productList
            .map((json) => RecentlyLikedProductModel.fromJson(json))
            .toList();
      }
    }

    // If no cache is available or it's expired, return an empty list
    return [];
  }

  Future<void> clearLikedSuggestedProductsCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cached_saved_products');
    cachedProducts.clear();
    productSuggestions.clear();
  }

}
