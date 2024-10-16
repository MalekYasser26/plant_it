import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:plant_it/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditData extends StatefulWidget {
  final Function loadData ;
  const EditData({super.key, required this.loadData()});

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String phoneNum = '';
  String address = '';

  // Controllers for TextFormFields
  late TextEditingController _nameController;
  late TextEditingController _phoneNumController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();

    // Initialize controllers
    _nameController = TextEditingController();
    _phoneNumController = TextEditingController();
    _addressController = TextEditingController();

    widget.loadData(); // Load the data
  }

  Future<void> _updateSharedPrefValue(String key, String newValue) async {
    // Get the SharedPreferences instance
    final prefs = await SharedPreferences.getInstance();

    // Update the value for the specified key
    await prefs.setString(key, newValue);

  }

  @override
  Widget build(BuildContext context) {
    var pCubit = context.read<ProfileCubit>();
    var sCubit = context.read<AuthCubit>();

    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSuccessfulState) {
          widget.loadData();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(
                'Profile updated successfully!',
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: AppColors.darkGreen,
            ),
          );
          Navigator.pop(context); // Close the modal
        } else if (state is ProfileFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              shape: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
              content: Text(
                'Profile failed to update!',
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: AppColors.darkGreen,
            ),
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
              controller: _nameController, // Use controller instead of initialValue
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
                _updateSharedPrefValue('name', value!);
              },
            ),

            // Phone Number TextFormField
            TextFormField(
              controller: _phoneNumController, // Use controller instead of initialValue
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
                _updateSharedPrefValue('phoneNum', value!);

              },
            ),

            // Address TextFormField
            TextFormField(
              controller: _addressController, // Use controller instead of initialValue
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
                _updateSharedPrefValue('address', value!);

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
