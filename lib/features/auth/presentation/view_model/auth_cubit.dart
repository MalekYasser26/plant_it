import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/favourites/presentation/view_model/liked_cubit.dart';
import 'package:plant_it/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  String errorMsg = '';
  String address = '';
  String name = '';
  String phoneNum = '';
  late int userID ;

  Future<void> signIn(String email, String password) async {
    emit(SigninLoadingState());
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print(1);
    try {
      final response = await http.post(
        Uri.parse('$baseUrlHasoon/Authentication/Login'),
        headers: {
          'Content-Type': 'application/json',
          'accept':'*/*',
        },
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );
      print(2);
      final responseBody = json.decode(response.body);
      var userData = responseBody['userData'];
      print(responseBody);
      if (response.statusCode == 200) {
        String accessToken = responseBody['token'];
        final refreshToken = responseBody['refreshToken'];
        name = userData['displayedName']??'';
        phoneNum = userData['phoneNumber']??'';
        address = userData['address']??'';
        userID = userData['id'];
        await prefs.setString('accessToken', accessToken);
        await prefs.setString('refreshToken', refreshToken);
        await prefs.setString('name', name);
        await prefs.setString('phoneNum', phoneNum);
        await prefs.setString('address', address);
        await prefs.setInt('userID', userID);
        emit(SigninSuccessState());
      } else {
        errorMsg = responseBody['message'];
        print(errorMsg);
        emit(SigninFailureState());
      }
      print(4);
    } catch (e) {
      print(5);
      print("catch : $email , $password");
      print(e.toString());
      emit(SigninFailureState());
    }
  }
  Future<int?> adjustUserID()async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt("userID");
  }

  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId:
    '969138196401-il0b3v9rd7gg31s7pt5e7uqa4ascbf0r.apps.googleusercontent.com',
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  Future<void> signInWithGoogle() async {
    emit(SigninLoadingState());

    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        // Obtain the auth details from the request
        final GoogleSignInAuthentication googleAuth = await googleUser
            .authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithCredential(credential);
        String? token = await userCredential.user?.getIdToken();
        final response = await http.post(
          Uri.parse('$baseUrlHasoon/Authentication/google-login?token=$token'),
          headers: {'Content-Type': 'application/json'},
        );
        final responseBody = json.decode(response.body);
        final prefs = await SharedPreferences.getInstance();
        prefs.clear();
        var userData = responseBody['userData'];
        //print(responseBody);
        if (response.statusCode == 200) {
          // Save tokens and user data
          print("google : $responseBody");
          String accessToken = responseBody['token'];
          String refreshToken = responseBody['refreshToken'];
          name = userData['displayedName'];
          phoneNum = userData['phoneNumber']??"";
          address = userData['address']??"";
          userID = userData['id'];
          // Store tokens and user data in SharedPreferences
          await prefs.setString('accessToken', accessToken);
          await prefs.setString('refreshToken', refreshToken);
          await prefs.setString('name', name);
          await prefs.setString('phoneNum', phoneNum);
          await prefs.setString('address', address);
          await prefs.setInt('userID', userID);
          emit(SigninSuccessState());

        } else {
          errorMsg = responseBody['message'];
          emit(SigninFailureState());
        }
      }
    } catch (e) {
      emit(SigninFailureState());
    }
  }
  Future<void> signUp(String email, String password, String displayedName, String phoneNum, String address) async {
    emit(SignupLoadingState());
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
    try {
      var userData = responseBody['data'];
      if (response.statusCode == 200 && responseBody['succeeded'] == true) {
        // Save tokens and user data
        String accessToken = responseBody['token'];
        final refreshToken = responseBody['refreshToken'];
        name = displayedName;
        this.phoneNum = phoneNum;
        this.address = address;
        userID = responseBody['data']['id'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken);
        await prefs.setString('refreshToken', refreshToken);
        await prefs.setString('name', name);
        await prefs.setString('phoneNum', phoneNum);
        await prefs.setString('address', address);
        await prefs.setInt('userID', userID);
        print("I AM HERE : $responseBody");
        emit(SignupSuccessState());
        print("ssad ${prefs.getString("accessToken")}");
        print("ssad ${prefs.getString("refreshToken")}");
        print("ssad ${prefs.getString("name")}");
        print("ssad ${prefs.getString("phoneNum")}");
        print("ssad ${prefs.getString("address")}");
        print("ssad ${prefs.getInt("userID")}");
      } else {
        errorMsg = responseBody['message'];
        print("Error here : $responseBody");
        emit(SignupFailureState());
      }
    } catch (e) {
      print("catch here : $responseBody");

      emit(SignupFailureState());
    }
  }
  Future<void> refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      String? refreshToken = prefs.getString('refreshToken');
      if (refreshToken == null) {
        throw Exception('No refresh token found');
      }
      final response = await http.post(
        Uri.parse('$baseUrlHasoon/Authentication/refreshToken?oldRefReshToken=$refreshToken'),
        headers: {
          'Authorization': 'Bearer ${prefs.getString("accessToken")}',
          'accept': '*/*',
        },
      );

      final responseBody = json.decode(response.body);
     // log(prefs.getString("refreshToken")!);
      // log(prefs.getString("accessToken")!);
      if (response.statusCode == 200 && responseBody['succeeded'] == true) {
        // Update tokens in memory and SharedPreferences
        String accessToken = responseBody['data']['accessToken'];
        refreshToken = responseBody['data']['refreshToken'];
        await prefs.setString('accessToken', accessToken);
        await prefs.setString('refreshToken', refreshToken!);
      } else {
        throw Exception('Failed to refresh token');
      }
    } catch (e) {
      //print('Error refreshing token: ${e.toString()}');
    }
  }
  Future<void> logOut(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
    await prefs.clear();
    if (context.mounted) {
      context.read<LikedCubit>().clearLikedProductsCache();
      context.read<ProfileCubit>().clearBookmarkedProductsCache();
    }
    emit(AuthInitial());
  }
  Future<void> googleSignOut(BuildContext context) async {
    try {
      // Sign out from Firebase
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('accessToken');
      await prefs.remove('refreshToken');
      await prefs.clear();
      if (context.mounted) {
        context.read<LikedCubit>().clearLikedProductsCache();
        context.read<ProfileCubit>().clearBookmarkedProductsCache();
      }
      emit(AuthInitial());
    } catch (e) {
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
