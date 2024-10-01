import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/profile/presentation/view_model/recently_saved_product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  List<RecentlySavedProductModel> savedProducts = [];
  late Map<int, int> bookmarkedProducts = {};
  Set<int> purchasedProductIDs = {};
  Map<int,String> orderStatuses = {};
  Map<int,String> orderStatusDates = {};

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
        print(
            "Failed to update user: ${response.statusCode}, ${response.body}");
      }
    } catch (error) {
      emit(ProfileFailureState()); // Emit failure state in case of error
      print("An error occurred: $error");
    }
  }

  Future<void> getRecentlySavedProducts(bool called) async {
    emit(RecentlySavedPurchasedLoadingState());
    if (savedProducts.isNotEmpty && called == false) {
      emit(RecentlySavedPurchasedSuccessfulState(savedProducts));
      return;
    } else {
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
          // Parse and map response to RecentlySavedProductModel
          for (var item in responseBody) {
            bookmarkedProducts[item['productId']] = item['id'];
          }
          savedProducts = responseBody
              .map((json) => RecentlySavedProductModel.fromJson(json))
              .toList();
          // Emit the fetched products
          emit(RecentlySavedPurchasedSuccessfulState(savedProducts));
        } else {
          emit(RecentlySavedPurchasedFailureState());
          print("Failed to load saved products: ${response.statusCode}");
        }
      } catch (error) {
        emit(RecentlySavedPurchasedFailureState());
        print("An error occurred: $error");
      }
    }
  }

  Future<void> getRecentlyPurchasedProducts(bool called, int userID) async {
    emit(RecentlySavedPurchasedLoadingState());
    {
      try {
        final response = await http.get(
          Uri.parse("$baseUrlArsoon/Order/$userID"),
          headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
        );

        if (response.statusCode == 200) {
          final responseBody = json.decode(response.body);
          for (var item in responseBody['Order']) {
            orderStatuses[item['id']] = item['status'] ;
            String date = item['order_date'];
            DateTime parsedDate = DateTime.parse(date);
            String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
            orderStatusDates[item['id']] = formattedDate ;
            if (item['status'] == "Delivered") {
              for (var x in item['order_items']) {
                purchasedProductIDs.add(x['product_id']);
              }
            }
          }
          print(groupDatesByStatus());
          emit(RecentlySavedPurchasedSuccessfulState(savedProducts));
        } else {
          emit(RecentlySavedPurchasedFailureState());
          print("Failed to load purchased products: ${response.statusCode}");
        }
      } catch (error) {
        emit(RecentlySavedPurchasedFailureState());
        print("An error occurred: $error");
      }
    }
  }

  Map<String, List<String>> groupDatesByStatus() {

    Map<String, List<String>> groupedByStatus = {
      'Pending': [],
      'Shipped': [],
      'Delivered': []
    };

    orderStatuses.forEach((id, status) {
      String? date = orderStatusDates[id];

      if (date != null && groupedByStatus.containsKey(status)) {
        groupedByStatus[status]?.add(date);
      }
    });

    return groupedByStatus;
  }
  Future<void> cacheProducts(List<RecentlySavedProductModel> products) async {
    final prefs = await SharedPreferences.getInstance();

    // Convert the product list to JSON for caching
    final String productsJson =
        json.encode(products.map((product) => product.toJson()).toList());

    // Store the cached products and the current time
    await prefs.setString('cached_saved_products', productsJson);
    await prefs.setInt('cache_time', DateTime.now().millisecondsSinceEpoch);
  }

  Future<List<RecentlySavedProductModel>> getCachedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? productsJson = prefs.getString('cached_saved_products');
    final int? cacheTime = prefs.getInt('cache_time');

    // Check if cache exists and is valid (within 1 hour)
    if (productsJson != null && cacheTime != null) {
      final int currentTime = DateTime.now().millisecondsSinceEpoch;
      const int cacheDuration = 60 * 60 * 1000; // 1 hour in milliseconds

      if (currentTime - cacheTime < cacheDuration) {
        // Convert the cached JSON string back to a list of RecentlySavedProductModel
        final List<dynamic> productList = json.decode(productsJson);
        return productList
            .map((json) => RecentlySavedProductModel.fromJson(json))
            .toList();
      }
    }

    // If no cache or expired, return an empty list
    return [];
  }
}
