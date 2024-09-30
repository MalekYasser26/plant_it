import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:plant_it/constants/constants.dart';
part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());
  Future<void> placeOrder(int userID) async {
    emit(CheckoutLoadingState());
    try {
      final response = await http.post(
        Uri.parse('$baseUrlArsoon/Order/$userID'),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
          // 'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        print("checkout done ");
        emit(CheckoutSuccessfulState());
      } else {
        print(response.body);
        emit(CheckoutFailureState());
        throw Exception('Failed to place order ');

      }
    } catch (e) {
      emit(CheckoutFailureState());
    }
  }

}
