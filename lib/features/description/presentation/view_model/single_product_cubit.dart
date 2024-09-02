import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:plant_it/features/description/presentation/view_model/single_product.dart';
import 'package:http/http.dart' as http;

part 'single_product_state.dart';

class SingleProductCubit extends Cubit<SingleProductState> {
  SingleProductCubit() : super(SingleProductInitial());

  Future<void> fetchProductById(int productId) async {
    emit(SingleProductLoadingState());

    try {
      final response = await http.get(
        Uri.parse('https://plantitnode.azurewebsites.net/api/Product/$productId'),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Parse the product from the JSON response
        final Map<String, dynamic> productJson = json.decode(response.body)['product'];
        final SingleProduct product = SingleProduct.fromJson(productJson);

        emit(SingleProductSuccessfulState(product));
      } else {
        throw Exception('Failed to load product');
      }
    } catch (e) {
      emit(SingleProductFailureState());
    }
  }
}
