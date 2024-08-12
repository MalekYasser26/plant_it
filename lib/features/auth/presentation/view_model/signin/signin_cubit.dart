import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:plant_it/constants/constants.dart';
part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit() : super(SigninInitialState());
  Future<void> signIn(String email, String password) async {
    emit(SigninLoadingState());
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/Authentication/Login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (responseBody['succeeded'] == true) {
          print(responseBody);
          emit(SigninSuccessState());
          // You can store token and user data here if needed
          String token = responseBody['token'];
          var userData = responseBody['userData'];
          // Store token and user data in secure storage or manage state
        } else {
          emit(SigninFailureState());
        }
      } else {
        emit(SigninFailureState());
      }
    } catch (e) {
      print(e.toString());  // Log the error for debugging purposes
      emit(SigninFailureState());
    }
  }
}
