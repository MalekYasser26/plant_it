import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:plant_it/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  Future<void> placeOrder(int userID) async {
    emit(CheckoutLoadingState());
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString("phoneNum")!.isEmpty ||
        prefs.getString("address")!.isEmpty) {
      emit(CheckoutDataIncompleteState());
    } else {
      try {
        final response = await http.post(
          Uri.parse('$baseUrlArsoon/Order/${prefs.getInt('userID')}'),
          headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer ${prefs.getString("accessToken")}',
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
}
