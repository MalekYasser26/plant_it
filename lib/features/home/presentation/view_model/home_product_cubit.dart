import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/home/presentation/view_model/home_product.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_product_state.dart';

class HomeProductsCubit extends Cubit<HomeProductState> {
  HomeProductsCubit() : super(ProductsInitial());

  // Fetch Products from API
  Future<void> fetchProducts(Future<void> getLikes ) async {
    await getLikes;
    emit(ProductsLoadingState());

    List<HomeProduct> cachedProducts = await getCachedProducts();
    if (cachedProducts.isNotEmpty) {
      emit(ProductsSuccessfulState(
          cachedProducts)); // Use cached data while loading fresh data
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrlArsoon/Product/GetAll'),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> productJson = json.decode(response.body);
        final List<HomeProduct> products =
            productJson.map((json) => HomeProduct.fromJson(json)).toList();

        // Cache products locally
        await cacheProducts(products);

        emit(ProductsSuccessfulState(products));
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      // If an error occurs, and no cached products are available
      if (cachedProducts.isEmpty) {
        print(e.toString());
        emit(ProductsFailureState()); // If no cache, show failure state
      }
    }
  }

  // Cache Products using SharedPreferences
  Future<void> cacheProducts(List<HomeProduct> products) async {
    final prefs = await SharedPreferences.getInstance();
    final String productsJson =
        json.encode(products.map((product) => product.toJson()).toList());
    await prefs.setString('cached_products', productsJson);
    await prefs.setInt('cache_time',
        DateTime.now().millisecondsSinceEpoch); // Store cache time
  }

  // Retrieve Cached Products from SharedPreferences
  Future<List<HomeProduct>> getCachedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? productsJson = prefs.getString('cached_products');
    final int? cacheTime = prefs.getInt('cache_time');

    // If cache is available and valid
    if (productsJson != null && cacheTime != null) {
      final int currentTime = DateTime.now().millisecondsSinceEpoch;
      const int cacheDuration = 60 * 60 * 1000; // Cache valid for 1 hour

      if (currentTime - cacheTime < cacheDuration) {
        final List<dynamic> productList = json.decode(productsJson);
        return productList.map((json) => HomeProduct.fromJson(json)).toList();
      } else {
        return []; // Cache expired
      }
    }

    return [];
  }

  Future<void> searchProducts(String searchedText, Future<void> getLikes) async {
    if (searchedText.isEmpty) {
      fetchProducts(
        getLikes
      );
      return;
    }
    emit(SearchLoadingState());
    try {
      final response = await http.get(
        Uri.parse('$baseUrlArsoon/Product/find/$searchedText'),
        headers: {'accept': 'application/json'},
      );
      if (response.statusCode == 200) {
        final productJson = json.decode(response.body)['product'];
        final products = productJson != null
            ? productJson.map<HomeProduct>((json) => HomeProduct.fromJson(json)).toList()
            : [];
        emit(SearchSuccessfulState(products)); // Emit the products from the search
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      emit(SearchFailureState());
    }
  }

// Cache search results
  Future<void> cacheSearchResults(String searchQuery, List<HomeProduct> products) async {
    final prefs = await SharedPreferences.getInstance();
    final String productsJson = json.encode(products.map((product) => product.toJson()).toList());
    await prefs.setString('search_$searchQuery', productsJson);
  }

// Retrieve cached search results
  Future<List<HomeProduct>> getCachedSearch(String searchQuery) async {
    final prefs = await SharedPreferences.getInstance();
    final String? searchJson = prefs.getString('search_$searchQuery');

    if (searchJson != null) {
      final List<dynamic> searchList = json.decode(searchJson);
      return searchList.map((json) => HomeProduct.fromJson(json)).toList();
    }
    return [];
  }
}
