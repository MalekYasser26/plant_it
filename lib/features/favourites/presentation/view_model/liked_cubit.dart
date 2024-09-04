import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:plant_it/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'liked_state.dart';

class LikedCubit extends Cubit<LikedState> {
  Map<int, int> likedProducts = {};
  LikedCubit() : super(LikedInitial());

  Future<void> getLikedProducts(int userID) async {
    emit(LoadLikeLoadingState());
    try {
      final response = await http.get(
        Uri.parse('$baseUrlHasoon/Likes/userId?userId=$userID'),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List<dynamic>;

        // Store the productId and likeId in the map
        likedProducts = {
          for (var item in data)
            item['productId']: item['id']
        };

        // Cache the liked products
        await cacheLikedProducts(likedProducts);
        emit(LoadLikeSuccessState());
      } else {
        throw Exception('Failed to load liked products');
      }
    } catch (e) {
      print(e.toString());
      emit(LoadLikeFailureState());
    }
  }

  Future<void> addLikedProducts(int productID) async {
    emit(AddLikeLoadingState());
    try {
      final response = await http.post(
        Uri.parse('$baseUrlHasoon/Likes?productId=$productID'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final int likeId = responseData['data']['id'];

        // Add the productId and corresponding likeId to the map
        likedProducts[productID] = likeId;

        await cacheLikedProducts(likedProducts);
        emit(AddLikeSuccessState());
      } else {
        throw Exception('Failed to add liked products');
      }
    } catch (e) {
      print(e.toString());
      emit(AddLikeFailureState());
    }
  }

  Future<void> removeLikedProducts(int productID) async {
    emit(RemoveLikeLoadingState());

    final likeID = likedProducts[productID];
    print('Removing like for productID: $productID, likeID: $likeID'); // Debugging

    if (likeID == null) {
      emit(RemoveLikeFailureState());
      print('Like ID not found for the given product ID');
      return;
    }

    try {
      final response = await http.delete(
        Uri.parse('$baseUrlHasoon/Likes/likeId?likeId=$likeID'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        // Remove the productID from likedProducts map
        print('Successfully removed like, response: ${response.body}');
        likedProducts.remove(productID);

        try {
          await cacheLikedProducts(likedProducts); // Check if there's an issue here
          emit(RemoveLikeSuccessState());
        } catch (e) {
          print('Error caching liked products: ${e.toString()}');
          emit(RemoveLikeFailureState());
        }
      } else {
        print('Failed to remove like, response: ${response.body}');
        throw Exception('Failed to remove liked product');
      }
    } catch (e) {
      print('Error in removeLikedProducts: ${e.toString()}');
      emit(RemoveLikeFailureState());
    }
  }


  Future<void> cacheLikedProducts(Map<int, int> likedProducts) async {
    final prefs = await SharedPreferences.getInstance();
    // Convert the Map<int, int> to Map<String, int> for JSON encoding
    final Map<String, int> likedProductsStringKeys = likedProducts.map((key, value) => MapEntry(key.toString(), value));

    await prefs.setString(
      'liked_products',
      json.encode(likedProductsStringKeys),
    );
  }

  Future<void> getCachedLikedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cachedLikedProductsString = prefs.getString('liked_products');
    if (cachedLikedProductsString != null) {
      // Decode and convert keys back to int
      final Map<String, dynamic> jsonMap = json.decode(cachedLikedProductsString);
      likedProducts = jsonMap.map<int, int>((key, value) => MapEntry(int.parse(key), value as int));
    }
  }
}
