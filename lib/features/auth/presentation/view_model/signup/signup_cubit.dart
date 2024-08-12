import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:plant_it/constants/constants.dart';
part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitialState());

  Future<void> signUp(String email, String password, String username, String displayedName, String phoneNum, String address) async {
    emit(SignupLoadingState());
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/Authentication/Register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'displayedName': displayedName,
          'email': email,
          'password': password,
          'phoneNum': phoneNum,
          'address': address
        }),
      );
      final responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        if (responseBody['succeeded'] == true) {
          print(responseBody);
          emit(SignupSuccessState());

          // Correct access to the token and user data
          String token = responseBody['token'];
          var userData = responseBody['data'];  // Updated this line

          // Store token and user data in secure storage or manage state
        } else {
          print(responseBody);
          emit(SignupFailureState());
        }
      } else {
        print(responseBody);
        emit(SignupFailureState());
      }
    } catch (e) {
      print(e.toString());  // Log the error for debugging purposes
      emit(SignupFailureState());
    }
  }
}
