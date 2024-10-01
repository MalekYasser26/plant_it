import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:plant_it/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  String errorMsg = '';
  String address = '';
  String name = '';
  String phoneNum = '';
  int userID =-1;

  Future<void> signIn(String email, String password) async {
    emit(SigninLoadingState());
    try {
      final response = await http.post(
        Uri.parse('$baseUrlHasoon/Authentication/Login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );
      final responseBody = json.decode(response.body);
      var userData = responseBody['userData'];
      if (response.statusCode == 200) {
        emit(SigninSuccessState());
        accessToken = responseBody['token'];
        name = userData['displayedName'];
        phoneNum = userData['phoneNumber'];
        address = userData['address'];
        userID = userData['id'];
      } else {
        errorMsg = responseBody['message'];
        emit(SigninFailureState());
      }
    } catch (e) {
      print(e.toString());
      emit(SigninFailureState());
    }
  }

  Future<void> signUp(String email, String password, String displayedName, String phoneNum, String address) async {
    emit(SignupLoadingState());
    try {
      final response = await http.post(
        Uri.parse('$baseUrlHasoon/Authentication/Register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': email,
          'displayedName': displayedName,
          'email': email,
          'password': password,
          'phoneNum': phoneNum,
          'address': address,
        }),
      );
      final responseBody = json.decode(response.body);
      var userData = responseBody['data'];
      if (response.statusCode == 200 && responseBody['succeeded'] == true) {
        emit(SignupSuccessState());
        accessToken = responseBody['token'];
        name = userData['displayedName'];
        this.phoneNum = userData['phoneNumber'];
        this.address = userData['address'];
      } else {
        errorMsg = responseBody['message'];
        emit(SignupFailureState());
      }
    } catch (e) {
      emit(SignupFailureState());
    }
  }

  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();

    // Remove the saved token or any other user data
    await prefs.clear();

    // Navigate to the login screen (assuming LoginScreen is the name of the widget)
  }

  // Add this method to update the user data when ProfileCubit updates the user profile
  void updateUserData({
    required String updatedName,
    required String updatedPhoneNum,
    required String updatedAddress,
  }) {
    // Update internal state
    name = updatedName;
    phoneNum = updatedPhoneNum;
    address = updatedAddress;

    // Emit a state change to refresh the UI
    emit(AuthUpdatedState());
  }
}
