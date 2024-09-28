import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:plant_it/constants/constants.dart';

part 'ratings_state.dart';

class RatingsCubit extends Cubit<RatingsState> {
  RatingsCubit() : super(RatingsInitial());
  Map<int, double> productRatings = {};

  Future<Map<int, double>> getProductRatings() async {
    emit(ProductRatingLoadingState());
    try {
      print("here 1");
      final response = await http.get(
        Uri.parse('$baseUrlHasoon/ProductRating/products/average'),
        headers: {
          'accept': '*/*',
        },
      );
      if (response.statusCode == 200) {
        print("here 2");
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final List<dynamic> data = jsonResponse['data'];
        print(data);
        print("here 3");
        for (var item in data) {
          print(item);
          productRatings[item['productId']] =
              (item['averageRating'] as num).toDouble();
        }
        print(productRatings);
        emit(ProductRatingSuccessfulState());
        return productRatings;
      } else {
        emit(ProductRatingFailureState());
        throw Exception(
            'Failed to load product ratings. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error occurred: $error');
      emit(ProductRatingFailureState());
      return {};
    }
  }

  double? isRatingFound(int productID) {
    if (productRatings.containsKey(productID)) {
      print("FOUNDDDDD");
      return productRatings[productID];
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

    try {
      final response = await http.post(
        Uri.parse('$baseUrlHasoon/ProductRating/ratings'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $accessToken',
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
            productRatings[productId] =
                (rating as num).toDouble();
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
  Future<void> editProductRating({
    required int productId,
    required int rating,
  }) async {
    emit(AddRatingLoadingState());
    try {
      final response = await http.put(
        Uri.parse('$baseUrlHasoon/ProductRating/ratings'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $accessToken',
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
          productRatings[productId] =
              (rating as num).toDouble();
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
    try {
      final response = await http.get(
        Uri.parse('$baseUrlHasoon/ProductRating/user/$productID'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $accessToken',
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
      }else {
        emit(GetUserRatingFailureState());
        throw Exception('Failed to load user rating. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error occurred: $error');
      emit(GetUserRatingFailureState());
    }

    return userRating; // Return the rating even if default
  }
}
