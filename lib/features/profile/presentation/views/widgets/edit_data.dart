import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:plant_it/features/profile/presentation/view_model/profile_cubit.dart';

class EditData extends StatefulWidget {
  const EditData({super.key});

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var pCubit = context.read<ProfileCubit>();
    var sCubit = context.read<AuthCubit>();

    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSuccessfulState) {
          // Show success Snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('Profile updated successfully!',
                  style:  TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                ),
            ),
            backgroundColor: AppColors.darkGreen,),
          );
          Navigator.pop(context); // Close the modal
        } else if (state is ProfileFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              shape: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
              content: Text('Profile failed to update!',
                style:  TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: AppColors.darkGreen,),
          );
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Name TextFormField
            TextFormField(
              initialValue: sCubit.name,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w300,
                  fontSize: getResponsiveSize(context, fontSize: 17),
                  color: AppColors.normGreen,
                ),
              ),
              keyboardType: TextInputType.name,
              onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              onSaved: (value) {
                sCubit.name = value ?? sCubit.name;
              },
            ),

            // Phone Number TextFormField
            TextFormField(
              initialValue: sCubit.phoneNum,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                labelStyle: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w300,
                  fontSize: getResponsiveSize(context, fontSize: 17),
                  color: AppColors.normGreen,
                ),
              ),
              onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
              onSaved: (value) {
                sCubit.phoneNum = value ?? sCubit.phoneNum;
              },
            ),

            // Address TextFormField
            TextFormField(
              initialValue: sCubit.address,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(
                labelText: 'Address',
                labelStyle: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w300,
                  fontSize: getResponsiveSize(context, fontSize: 17),
                  color: AppColors.normGreen,
                ),
              ),
              onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
              onSaved: (value) {
                sCubit.address = value ?? sCubit.address;
              },
            ),

            const SizedBox(height: 20),

            // CircularProgressIndicator or Save Button
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoadingState) {
                  return const CircularProgressIndicator(
                    color: AppColors.darkGreen,
                  );
                } else {
                  return ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        // Trigger profile update in ProfileCubit
                        pCubit.updateUser(
                          address: sCubit.address,
                          phoneNumber: sCubit.phoneNum,
                          displayedName: sCubit.name,
                        );
                      }
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w300,
                        fontSize: getResponsiveSize(context, fontSize: 15),
                        color: AppColors.normGreen,
                      ),
                    ),
                  );
                }
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
