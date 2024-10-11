import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'ratings_state.dart';

class RatingsCubit extends Cubit<RatingsState> {
  RatingsCubit() : super(RatingsInitial());
  Map<int, double> productRatings = {};
  Map<int, double> cachedRatings = {};
  Map<int, double> userCachedRatings = {};

  Future<Map<int, double>> getProductRatings(bool called) async {
    // First, try to get cached ratings
     cachedRatings = await getCachedProductRatings();
    if (cachedRatings.isNotEmpty && called == false) {
      emit(ProductRatingSuccessfulState());
      return cachedRatings;
    }
    emit(ProductRatingLoadingState());
    try {
      final response = await http.get(
        Uri.parse('$baseUrlHasoon/ProductRating/products/average'),
        headers: {
          'accept': '*/*',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final List<dynamic> data = jsonResponse['data'];

        Map<int, double> productRatings = {};
        for (var item in data) {
          productRatings[item['productId']] =
              (item['averageRating'] as num).toDouble();
        }
          print("here 1" );
        // Cache the product ratings after fetching
        await cacheProductRatings(productRatings);

        emit(ProductRatingSuccessfulState());
        return productRatings;
      } else {
        emit(ProductRatingFailureState());
        throw Exception('Failed to load product ratings. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error occurred: $error');
      emit(ProductRatingFailureState());
      return {};
    }
  }

  double? isRatingFound(int productID) {
    print(cachedRatings);
    if (cachedRatings.containsKey(productID)) {
      print("FOUNDDDDD");
      return cachedRatings[productID];
    } else {
      print("NOT FOUNDDDDD");
      return -1;
    }
  }

  Future<void> addProductRating({
    required int productId,
    required int rating,
  }) async {
    emit(AddRatingLoadingState());
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("accessToken"));
    print("I am ");
    try {
      final response = await http.post(
        Uri.parse('$baseUrlHasoon/ProductRating/ratings'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer ${prefs.getString("accessToken")}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'productId': productId,
          'review': '',
          'rating': rating,
        }),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['succeeded']) {
          productRatings[productId] = (rating as num).toDouble();
          emit(AddRatingSuccessfulState());
        } else {
          print("${prefs.getString('accessToken')}");
          throw Exception('Failed to add rating: ${responseData['message']}');
        }
      } else {
        print("${prefs.getString('accessToken')}");
        throw Exception('Failed to add rating: ${response.body}');
      }
    } catch (e) {
      print("catch : ");
      print(e.toString());
      emit(AddRatingFailureState(message: e.toString()));
    }
  }

  Future<void> editProductRating({
    required int productId,
    required int rating,
  }) async {
    emit(AddRatingLoadingState());
    final prefs = await SharedPreferences.getInstance();
    try {
      final response = await http.put(
        Uri.parse('$baseUrlHasoon/ProductRating/ratings'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer ${prefs.getString("accessToken")}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'productId': productId,
          'review': '',
          'rating': rating,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['succeeded']) {
          productRatings[productId] = (rating as num).toDouble();
          emit(AddRatingSuccessfulState());
        } else {
          throw Exception('Failed to add rating: ${responseData['message']}');
        }
      } else {
        throw Exception('Failed to add rating: ${response.body}');
      }
    } catch (e) {
      print("catch : ");
      print(e.toString());
      emit(AddRatingFailureState(message: e.toString()));
    }
  }

  Future<double> getCurrentProductUserRating(int productID) async {
    double userRating = 0.0; // Initialize with default value
    emit(GetUserRatingLoadingState());
    final prefs = await SharedPreferences.getInstance();
    try {
      final response = await http.get(
        Uri.parse('$baseUrlHasoon/ProductRating/user/$productID'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer ${prefs.getString("accessToken")}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData);
        userRating = responseData['rating'] * 1.0 ?? 0;
        emit(GetUserRatingSuccessState(
          userRating: userRating,
        ));
      } else if (response.statusCode == 404) {
        print("no rating here ");
        userRating = 0;
        emit(GetUserRatingSuccessState(
          userRating: userRating,
        ));
      } else {
        emit(GetUserRatingFailureState());
        throw Exception(
            'Failed to load user rating. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error occurred: $error');
      emit(GetUserRatingFailureState());
    }

    return userRating;
  }

  Future<void> cacheProductRatings(Map<int, double> ratings) async {
    final prefs = await SharedPreferences.getInstance();

    // Convert the map keys (int) to string for encoding
    final ratingsJson = json.encode(
        ratings.map((key, value) => MapEntry(key.toString(), value))
    );

    // Store the cached ratings and the current time
    await prefs.setString('cached_product_ratings', ratingsJson);
    await prefs.setInt(
        'ratings_cache_time', DateTime.now().millisecondsSinceEpoch);
  }

  Future<Map<int, double>> getCachedProductRatings() async {
    final prefs = await SharedPreferences.getInstance();
    final String? ratingsJson = prefs.getString('cached_product_ratings');
    final int? cacheTime = prefs.getInt('ratings_cache_time');

    if (ratingsJson != null && cacheTime != null) {
      final int currentTime = DateTime.now().millisecondsSinceEpoch;
      const int cacheDuration = 60 * 60 * 1000; // 1 hour in milliseconds

      if (currentTime - cacheTime < cacheDuration) {
        // Decode the JSON string and convert keys back to int
        final Map<String, dynamic> ratingsMap = json.decode(ratingsJson);
        return ratingsMap.map((key, value) =>
            MapEntry(int.parse(key), (value as num).toDouble()));
      }
    }

    return {};
  }
}
