import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:plant_it/constants/constants.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  String errorMsg ='' ;
  String address = '';
  String name = '';
  String phoneNum = '';
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
      var userData = responseBody['userData'];
      if (response.statusCode == 200) {
        print(responseBody);
        emit(SigninSuccessState());
        String token = responseBody['token'];
        name = userData['displayedName'];
        phoneNum = userData['phoneNumber'];
        address = userData['address'];
        print(name);
        print(phoneNum);
        print(address);
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
        name = userData['displayedName'];
        phoneNum = userData['phoneNumber'];
        address = userData['address'];
        print(name);
        print(phoneNum);
        print(address);
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
