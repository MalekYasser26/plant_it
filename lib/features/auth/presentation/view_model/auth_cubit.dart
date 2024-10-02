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
  int userID = -1;

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
        // Save tokens and user data
        emit(SigninSuccessState());
        accessToken = responseBody['token'];
        final refreshToken = responseBody['refreshToken'];

        name = userData['displayedName'];
        phoneNum = userData['phoneNumber'];
        address = userData['address'];
        userID = userData['id'];

        // Store tokens in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken!);
        await prefs.setString('refreshToken', refreshToken);

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
        // Save tokens and user data
        emit(SignupSuccessState());
        accessToken = responseBody['token'];
        final refreshToken = responseBody['refreshToken'];

        name = userData['displayedName'];
        this.phoneNum = userData['phoneNumber'];
        this.address = userData['address'];

        // Store tokens in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken!);
        await prefs.setString('refreshToken', refreshToken);

      } else {
        errorMsg = responseBody['message'];
        emit(SignupFailureState());
      }
    } catch (e) {
      emit(SignupFailureState());
    }
  }

  Future<void> refreshToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? refreshToken = prefs.getString('refreshToken');
      if (refreshToken == null) {
        throw Exception('No refresh token found');
      }

      final response = await http.post(
        Uri.parse('$baseUrlHasoon/Authentication/refreshToken?oldRefReshToken=$refreshToken'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'accept': '*/*',
        },
      );

      final responseBody = json.decode(response.body);
      if (response.statusCode == 200 && responseBody['succeeded'] == true) {
        // Update tokens in memory and SharedPreferences
        accessToken = responseBody['data']['accessToken'];
        refreshToken = responseBody['data']['refreshToken'];

        await prefs.setString('accessToken', accessToken!);
        await prefs.setString('refreshToken', refreshToken!);

      } else {
        throw Exception('Failed to refresh token');
      }
    } catch (e) {
      print('Error refreshing token: ${e.toString()}');
    }
  }

  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    emit(AuthInitial());
  }
  Future<void> checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedAccessToken = prefs.getString('accessToken');

    if (savedAccessToken != null) {
      accessToken = savedAccessToken;
      emit(AuthAuthenticatedState()); // Assuming this state exists
    } else {
      emit(AuthInitial()); // Emit initial state if no token
    }
  }

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
