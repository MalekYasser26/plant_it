import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:plant_it/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'liked_state.dart';

class LikedCubit extends Cubit<LikedState> {
  List<int> likedProductIds = [];

  LikedCubit() : super(LikedInitial());

  Future<void> getLikedProducts(int userID) async {
    emit(LikeLoadingState());
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
        likedProductIds = data.map<int>((item) => item['productId']).toList();
        // Cache the liked products
        await cacheLikedProducts(likedProductIds);
        print((likedProductIds));
        emit(LikeSuccessState());
      } else {
        throw Exception('Failed to load liked products');
      }
    } catch (e) {
      // If an error occurs
      print(e.toString());
      emit(LikeFailureState());
    }
  }

  Future<void> toggleLike(int productId) async {
    if (likedProductIds.contains(productId)) {
      likedProductIds.remove(productId);
    } else {
      likedProductIds.add(productId);
    }

    // Cache the updated liked products
    await cacheLikedProducts(likedProductIds);

    emit(LikeSuccessState());
  }

  Future<void> cacheLikedProducts(List<int> likedProductIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('liked_products', likedProductIds.map((id) => id.toString()).toList());
  }

  Future<void> getCachedLikedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? cachedLikedProducts = prefs.getStringList('liked_products');
    if (cachedLikedProducts != null) {
      likedProductIds = cachedLikedProducts.map((id) => int.parse(id)).toList();
    }
  }
}
