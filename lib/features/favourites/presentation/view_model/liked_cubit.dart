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
        likedProductIds = data.map<int>((item) => item['productId']).toList();
        // Cache the liked products
        await cacheLikedProducts(likedProductIds);
        print((likedProductIds));
        emit(LoadLikeSuccessState());
      } else {
        throw Exception('Failed to load liked products');
      }
    } catch (e) {
      // If an error occurs
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
        print(response.body);
        likedProductIds.add(productID);
        await cacheLikedProducts(likedProductIds);
        print((likedProductIds));
        emit(AddLikeSuccessState());
      } else {
        print(response.body);
        throw Exception('Failed to add liked products');
      }
    } catch (e) {
      // If an error occurs
      print(e.toString());
      emit(AddLikeFailureState());
    }
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
