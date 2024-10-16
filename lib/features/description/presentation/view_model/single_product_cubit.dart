import 'dart:async';
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
  SingleProductCubit() : super(SingleProductInitial(
      SingleProduct(id: -1, productName: '', price: '0', bio: '', availableStock: 0, likesCounter: 0, images: [], productCategories: [])

  ));
  Timer? _debounce; // Timer for debouncing requests

  Future<void> fetchProductById(SingleProduct product) async {
    emit(SingleProductLoadingState(product));
    try {
      final response = await http.get(
        Uri.parse('$baseUrlArsoon/Product/${product.id}'),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final productJson = json.decode(response.body)['product'];
        final SingleProduct product = SingleProduct.fromJson(productJson);
        emit(SingleProductSuccessfulState(product));
      } else {
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


  Future<void> addBookmarkedProducts(SingleProduct product , Map<int, int> bookmarkedProducts) async {
    // Debounce logic
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel(); // Cancel any ongoing debounce timer
    }
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      emit(AddBookmarkLoadingState(product));
      final prefs = await SharedPreferences.getInstance();
      try {
        final response = await http.post(
          Uri.parse('$baseUrlHasoon/Bookmark?productId=${product.id}'),
          headers: {
            'accept': '*/*',
            'Authorization': 'Bearer ${prefs.getString("accessToken")}',
          },
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);
          final int bookmarkID = responseData['data']['id'];
          bookmarkedProducts[product.id] = bookmarkID;
          await cacheBookmarkedProducts(bookmarkedProducts);
          emit(AddBookmarkSuccessfulState(product: product));
        } else {

          emit(AddBookmarkFailureState(product));
        }
      } catch (e) {
        emit(AddBookmarkFailureState(product));
      }
    });
  }

  Future<void> removeBookmarkedProducts(SingleProduct product,Map<int, int> bookmarkedProducts) async {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel(); // Cancel any ongoing debounce timer
    }

    _debounce = Timer(const Duration(milliseconds: 300), () async {
      final prefs = await SharedPreferences.getInstance();
      emit(RemoveBookmarkLoadingState(product));
      final bookmarkID = bookmarkedProducts[product.id];
      if (bookmarkID == null) {
        emit(RemoveBookmarkFailureState(product));
        return;
      }

      try {
        final response = await http.delete(
          Uri.parse('$baseUrlHasoon/Bookmark/BookmarkId?BookmarkId=$bookmarkID'),
          headers: {
            'accept': '*/*',
            'Authorization': 'Bearer ${prefs.getString("accessToken")}',
          },
        );

        if (response.statusCode == 200) {
          bookmarkedProducts.remove(product.id);
          await cacheBookmarkedProducts(bookmarkedProducts);
          emit(RemoveBookmarkSuccessfulState(product: product));
        } else {
          throw Exception('Failed to remove bookmarked product');
        }
      } catch (e) {
        emit(RemoveBookmarkFailureState(product));
      }
    });
  }


  Future<void> cacheBookmarkedProducts(Map<int, int> bookmarkedProducts) async {
    final prefs = await SharedPreferences.getInstance();
    final Map<String, int> bookmarkedProductsStringKeys =
    bookmarkedProducts.map((key, value) => MapEntry(key.toString(), value));
    await prefs.setString('bookmarked_products', json.encode(bookmarkedProductsStringKeys));
  }

  Future<void> getCachedBookmarkedProducts(Map<int, int> bookmarkedProducts) async {
    final prefs = await SharedPreferences.getInstance();
    final String? cachedBookmarkedProductsString = prefs.getString('bookmarked_products');
    if (cachedBookmarkedProductsString != null) {
      final Map<String, dynamic> jsonMap = json.decode(cachedBookmarkedProductsString);
      bookmarkedProducts = jsonMap.map<int, int>((key, value) => MapEntry(int.parse(key), value));
    }
  }


  bool isBookmarked(int productID,Map<int, int> bookmarkedProducts) {
    return bookmarkedProducts.containsKey(productID);
  }
}
