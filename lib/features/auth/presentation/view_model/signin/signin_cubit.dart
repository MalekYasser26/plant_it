import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:plant_it/constants/constants.dart';
part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit() : super(SigninInitialState());
  String errorMsg ='' ;
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
      final responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
          print(responseBody);
          emit(SigninSuccessState());
          String token = responseBody['token'];
          var userData = responseBody['userData'];
          print(userData);
      } else {
        errorMsg =responseBody['message'];
        print("Error is ${responseBody['message']}");
        emit(SigninFailureState());
      }
    } catch (e) {
      print(e.toString());  // Log the error for debugging purposes
      emit(SigninFailureState());
    }
  }
}
