import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/description/presentation/view_model/single_product.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'single_product_state.dart';

class SingleProductCubit extends Cubit<SingleProductState> {
  late Map<int, int> bookmarkedProducts = {};

  SingleProductCubit() : super(SingleProductInitial(
      SingleProduct(id: -1, productName: '', price: '0', bio: '', availableStock: 0, likesCounter: 0, images: [], productCategories: [])

  ));

  Future<void> fetchProductById(int userID,SingleProduct product) async {
    emit(SingleProductLoadingState(product)); // Emit loading state before fetch
    try {
      final response = await http.get(
        Uri.parse('$baseUrlArsoon/Product/${product.id}'),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final productJson = json.decode(response.body)['product'];
        final SingleProduct product = SingleProduct.fromJson(productJson);
        await getProductsBookmarks(userID, product);  // Get bookmarks
        emit(SingleProductSuccessfulState(product));
      } else {
        print(response.body);
        emit(SingleProductFailureState(product));
      }
    } catch (e) {
      print(e.toString());
      emit(SingleProductFailureState(product));
    }
  }

  Future<void> fetchProductImagesById(SingleProduct product) async {
    emit(ProductImagesLoadingState(product));

    try {
      final response = await http.get(
        Uri.parse('$baseUrlArsoon/Images/${product.id}'),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        emit(ProductImagesSuccessfulState(product));
      } else {
        throw Exception('Failed to load product');
      }
    } catch (e) {
      emit(ProductImagesFailureState(product));
    }
  }

  Future<void> getProductsBookmarks(int userID,SingleProduct product) async {
    emit(BookmarkLoadingState(product));
    try {
      final response = await http.get(
        Uri.parse('$baseUrlHasoon/Bookmark/userId?userId=$userID'),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        for (var item in result) {
          bookmarkedProducts[item['productId']] = item['id'];
        }
        await cacheBookmarkedProducts(bookmarkedProducts); // Cache the bookmarks
        emit(BookmarkSuccessfulState(product));
      } else {
        throw Exception('Failed to load bookmark');
      }
    } catch (e) {
      print(e.toString());
      emit(BookmarkFailureState(product));
    }
  }

  Future<void> addBookmarkedProducts(SingleProduct product) async {
    emit(AddBookmarkLoadingState(product));
    try {
      final response = await http.post(
        Uri.parse('$baseUrlHasoon/Bookmark?productId=${product.id}'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final int bookmarkID = responseData['data']['id'];
        bookmarkedProducts[product.id] = bookmarkID;
        await cacheBookmarkedProducts(bookmarkedProducts);
        emit(AddBookmarkSuccessfulState(product: product));
      } else {
        print(response.body);
        emit(AddBookmarkFailureState(product));
      }
    } catch (e) {
      print(e.toString());
      emit(AddBookmarkFailureState(product));
    }
  }

  Future<void> removeBookmarkedProducts(SingleProduct product) async {
    emit(RemoveBookmarkLoadingState(product));
    final bookmarkID = bookmarkedProducts[product.id];

    if (bookmarkID == null) {
      debugPrint("null");
      emit(RemoveBookmarkFailureState(product));
      return;
    }

    try {
      final response = await http.delete(
        Uri.parse('$baseUrlHasoon/Bookmark/BookmarkId?BookmarkId=$bookmarkID'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        bookmarkedProducts.remove(product.id);
        await cacheBookmarkedProducts(bookmarkedProducts);
        emit(RemoveBookmarkSuccessfulState(product: product));
        debugPrint(response.body);
      } else {
        debugPrint(response.body);
        throw Exception('Failed to remove liked product');
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(RemoveBookmarkFailureState(product));
    }
  }


  Future<void> cacheBookmarkedProducts(Map<int, int> bookmarkedProducts) async {
    final prefs = await SharedPreferences.getInstance();
    final Map<String, int> bookmarkedProductsStringKeys =
    bookmarkedProducts.map((key, value) => MapEntry(key.toString(), value));

    await prefs.setString('bookmarked_products', json.encode(bookmarkedProductsStringKeys));
  }

  Future<void> getCachedBookmarkedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cachedBookmarkedProductsString = prefs.getString('bookmarked_products');
    if (cachedBookmarkedProductsString != null) {
      final Map<String, dynamic> jsonMap = json.decode(cachedBookmarkedProductsString);
      bookmarkedProducts = jsonMap.map<int, int>((key, value) => MapEntry(int.parse(key), value));
    }
  }


  bool isBookmarked(int productID) {
    return bookmarkedProducts.containsKey(productID);
  }
}
