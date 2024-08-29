import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:plant_it/constants/constants.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> updateUser({
    required String address,
    required String phoneNumber,
    required String displayedName,
    //required String profilePic,
  }) async {
    emit(ProfileLoadingState()); // Emit loading state

    try {
      // Creating the body for the PUT request
      Map<String, String> requestBody = {
        "address": address,
        "phoneNumber": phoneNumber,
        "displayedName": displayedName,
        //  "profilePic": profilePic,
      };

      // Sending the PUT request
      final response = await http.put(
        Uri.parse('$baseUrlHasoon/Authentication/UpdateUser'),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(requestBody),
      );

      // Checking the response status
      if (response.statusCode == 200) {
        emit(ProfileSuccessfulState()); // Emit success state
        print("User updated successfully: ${response.body}");
      } else {
        emit(ProfileFailureState()); // Emit failure state
        print("Failed to update user: ${response.statusCode}, ${response.body}");
      }
    } catch (error) {
      emit(ProfileFailureState()); // Emit failure state in case of error
      print("An error occurred: $error");
    }
  }
}
