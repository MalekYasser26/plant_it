import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

        // Store tokens and user data in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken!);
        await prefs.setString('refreshToken', refreshToken);
        await prefs.setString('name', name);
        await prefs.setString('phoneNum', phoneNum);
        await prefs.setString('address', address);
        await prefs.setInt('userID', userID);

      } else {
        errorMsg = responseBody['message'];
        emit(SigninFailureState());
      }
    } catch (e) {
      print(e.toString());
      emit(SigninFailureState());
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // User interactive UI
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // await prefs.setString('googleUserId', googleUser.id);
        // await prefs.setString('googleUserEmail', googleUser.email);
        // await prefs.setString('googleUserName', googleUser.displayName ?? '');
        // await prefs.setString('googleUserPhotoUrl', googleUser.photoUrl ?? '');
        // await prefs.setString('googleAccessToken', googleAuth.accessToken ?? '');
        // await prefs.setString('googleIdToken', googleAuth.idToken ?? '');

        // Optional: Navigate to the next screen or perform additional actions
       // Navigator.pushReplacementNamed(context, '/home'); // Navigate to home screen

        // Print user info for debugging
        print('Signed in with Google: ${googleUser.email}');
        print('${googleAuth.accessToken.toString()}');
       // print('ya29.a0AcM612wnIn3JwkC6pgmSCIojkYiqJqFlAV1qpv3f6ygEzHjZnnMh1nqibMl7vPOb3Y5lYR_MyEhIoVvypFf9zK4JBMvhM9oRbICIfNzZ5ILgWob3w1XgPNZoaros8DvgdIIJq5U8MOSGaKuq-fOwlDGyNEJF0Lz86HJ6me66aCgYKAaESARISFQHGX2MilTBTJCviTETVLgE_TgOGqA0175');
      } else {
        print('Google Sign-In aborted');
      }
    } catch (error) {
      print('Error during Google Sign-In: $error');
      // Optionally, show an error message to the user
    }
  }

  Future<void> signOutFromGoogle(BuildContext context) async {
    try {
      await _googleSignIn.signOut();
      // Clear any saved user data
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      print('User signed out from Google');
    } catch (error) {
      print('Error signing out from Google: $error');
    }
  }  Future<void> signUp(String email, String password, String displayedName, String phoneNum, String address) async {
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
  Future<String?> getName()async{
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString('name'));
    return prefs.getString('name');
  }
  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    emit(AuthInitial());
  }
  Future<void> checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedAccessToken = prefs.getString('accessToken');

    if (savedAccessToken != null) {
      accessToken = savedAccessToken;
      name = prefs.getString('name') ?? '';
      phoneNum = prefs.getString('phoneNum') ?? '';
      address = prefs.getString('address') ?? '';
      userID = prefs.getInt('userID') ?? -1;

      emit(AuthAuthenticatedState());
    } else {
      emit(AuthInitial()); // Emit initial state if no token
    }
  }

  void updateUserData({
    required String updatedName,
    required String updatedPhoneNum,
    required String updatedAddress,
  }) async {
    // Update internal state
    name = updatedName;
    phoneNum = updatedPhoneNum;
    address = updatedAddress;

    // Cache updated data
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', updatedName);
    await prefs.setString('phoneNum', updatedPhoneNum);
    await prefs.setString('address', updatedAddress);

    // Emit a state change to refresh the UI
    emit(AuthUpdatedState());
  }

}
