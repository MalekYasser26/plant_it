import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:plant_it/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'liked_state.dart';

class LikedCubit extends Cubit<LikedState> {
  Map<int, int> likedProducts = {};

  LikedCubit() : super(LikedInitial()) {
    // Load cached liked products during initialization
    _initializeLikedProducts();
  }

  Future<void> _initializeLikedProducts() async {
    await getCachedLikedProducts();
    // After loading from cache, you can emit success if needed
    emit(LoadLikeSuccessState(likeCounter: 0, productID: -1));
  }

  Future<void> addLikedProducts(int productID) async {
    emit(AddLikeLoadingState(likeCounter: 0, productID: -1));
    final prefs = await SharedPreferences.getInstance();
    try {
      final response = await http.post(
        Uri.parse('$baseUrlHasoon/Likes?productId=$productID'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer ${prefs.getString("accessToken")}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final int likeId = responseData['data']['addedLike']['id'];
        likedProducts[productID] = likeId;
        int likeCounter = responseData['data']['addedLike']['product']['likesCounter'];
        // Cache the updated liked products
        await cacheLikedProducts(likedProducts);
        emit(AddLikeSuccessState(likeCounter: likeCounter, productID: productID));
      } else {
        throw Exception('Failed to add liked products');
      }
    } catch (e) {
      print(e.toString());
      print(productID);
      emit(AddLikeFailureState(likeCounter: 0, productID: -1));
    }
  }

  Future<void> removeLikedProducts(int productID) async {
    final prefs = await SharedPreferences.getInstance();
    emit(RemoveLikeLoadingState(likeCounter: 0, productID: -1));
    final likeID = likedProducts[productID];
    if (likeID == null) {
      print("$productID : ssssss");
      emit(RemoveLikeFailureState(likeCounter: 0, productID: -1));
      return;
    }

    try {
      print("trying 1 ");
      final response = await http.delete(
        Uri.parse('$baseUrlHasoon/Likes/likeId?likeId=$likeID'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer ${prefs.getString("accessToken")}',
        },
      );
      print(response.statusCode);
      print(prefs.getString('accessToken'));
      if (response.statusCode == 200) {
        print("trying 2 ");
        likedProducts.remove(productID);
        final Map<String, dynamic> responseData = json.decode(response.body);
        int likeCounter = responseData['data'];

        // Cache the updated liked products
        await cacheLikedProducts(likedProducts);
        emit(RemoveLikeSuccessState(likeCounter: likeCounter, productID: productID));
      } else {
        print(json.decode(response.body));
        throw Exception('Failed to remove liked product');
      }
    } catch (e) {
      print(e.toString());
      emit(RemoveLikeFailureState(likeCounter: 0, productID: -1));
    }
  }

  Future<void> getLikedProducts(int userID) async {
    emit(LoadLikeLoadingState(likeCounter: 0, productID: -1));
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getInt('userID'));
    // Check if we have cached liked products first
    if (likedProducts.isNotEmpty) {
      emit(LoadLikeSuccessState(likeCounter: 0, productID: -1));
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrlHasoon/Likes/userId?userId=${prefs.getInt('userID')}'),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${prefs.getString("accessToken")}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];

        // Store the productId and likeId in the map
        likedProducts = {
          for (var item in data)
            item['productId']: item['id']
        };

        // Cache the liked products
        await cacheLikedProducts(likedProducts);
        emit(LoadLikeSuccessState(likeCounter: 0, productID: -1));
      } else {
        throw Exception('Failed to load liked products');
      }
    } catch (e) {
      print(e.toString());
      emit(LoadLikeFailureState(likeCounter: 0, productID: -1));
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
      final Map<String, dynamic> jsonMap = json.decode(cachedLikedProductsString);
      likedProducts = jsonMap.map<int, int>((key, value) => MapEntry(int.parse(key), value as int));
    }
  }
}
