import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:plant_it/constants/constants.dart';
part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitialState());
  String errorMsg ='' ;

  Future<void> signUp(String email, String password, String displayedName, String phoneNum, String address) async {
    emit(SignupLoadingState());
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/Authentication/Register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': email,
          'displayedName': displayedName,
          'email': email,
          'password': password,
          'phoneNum': phoneNum,
          'address': address
        }),
      );
      final responseBody = json.decode(response.body);
      var userData = responseBody['data'];
      if (response.statusCode == 200 &&responseBody['succeeded'] == true) {
          print(responseBody);
          emit(SignupSuccessState());
          String token = responseBody['token'];
          print("_____________");
          print(userData);
      } else {
        errorMsg =responseBody['message'];
        print("Error is ${responseBody['message']}");
        emit(SignupFailureState());
      }
    } catch (e) {
      print(e.toString());  // Log the error for debugging purposes
      emit(SignupFailureState());
    }
  }
}
