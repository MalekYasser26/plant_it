import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:plant_it/features/home/presentation/view_model/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  // Fetch Products from API
  Future<void> fetchProducts() async {
    emit(ProductsLoadingState());

    // First, try to load cached data
    List<HomeProduct> cachedProducts = await getCachedProducts();

    if (cachedProducts.isNotEmpty) {
      emit(ProductsSuccessfulState(cachedProducts)); // Use cached data while loading fresh data
    }

    try {
      final response = await http.get(
        Uri.parse('https://plantitnode.azurewebsites.net/api/Product/GetAll'),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> productJson = json.decode(response.body);
        final List<HomeProduct> products = productJson.map((json) => HomeProduct.fromJson(json)).toList();

        // Cache products locally
        await cacheProducts(products);

        emit(ProductsSuccessfulState(products));
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      // If an error occurs, and no cached products are available
      if (cachedProducts.isEmpty) {
        emit(ProductsFailureState()); // If no cache, show failure state
      }
    }
  }

  // Fetch Product by ID from API

  // Cache Products using SharedPreferences
  Future<void> cacheProducts(List<HomeProduct> products) async {
    final prefs = await SharedPreferences.getInstance();
    final String productsJson = json.encode(products.map((product) => product.toJson()).toList());
    await prefs.setString('cached_products', productsJson);
    await prefs.setInt('cache_time', DateTime.now().millisecondsSinceEpoch); // Store cache time
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
}
