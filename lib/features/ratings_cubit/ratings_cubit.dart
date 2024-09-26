import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:plant_it/constants/constants.dart';

part 'ratings_state.dart';

class RatingsCubit extends Cubit<RatingsState> {
  RatingsCubit() : super(RatingsInitial());
   Map<int, int> productRatings = {} ;
  Future<Map<int, int>> getProductRatings() async {
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
        productRatings= {
          for (var item in data)
            item['productId']: item['averageRating']
        };
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
  int? isRatingFound(int productID){
    if (productRatings.containsKey(productID)){
      print("FOUNDDDDD");
      return productRatings[productID] ;
    } else {
      print("NOT FOUNDDDDD");
      return -1 ;
    }
  }

}
