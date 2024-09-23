import 'dart:convert';

import 'package:plant_it/features/description/presentation/view_model/single_product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkCacheManager {
  static const String _bookmarkedProductsKey = 'bookmarked_products';

  // Cache full products
  static Future<void> cacheBookmarkedProducts(Map<int, SingleProduct> bookmarkedProducts) async {
    final prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> bookmarkedProductsJson =
    bookmarkedProducts.map((key, value) => MapEntry(key.toString(), value.toJson()));
    await prefs.setString(_bookmarkedProductsKey, json.encode(bookmarkedProductsJson));
  }

  // Get cached products
  static Future<Map<int, SingleProduct>> getCachedBookmarkedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cachedBookmarkedProductsString = prefs.getString(_bookmarkedProductsKey);

    if (cachedBookmarkedProductsString != null) {
      final Map<String, dynamic> jsonMap = json.decode(cachedBookmarkedProductsString);
      return jsonMap.map<int, SingleProduct>((key, value) => MapEntry(int.parse(key), SingleProduct.fromJson(value)));
    }

    return {};
  }
}
