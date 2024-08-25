import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';

class EditData extends StatefulWidget {
  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final _formKey = GlobalKey<FormState>();
  String _name = "Bruno";
  String _phone = "+20 1076927763";
  String _address = "13, Al-Doha st, Mansoura";

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            initialValue: _name,
            decoration:  InputDecoration(labelText: 'Name', labelStyle:
             TextStyle(
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
              _name = value ?? _name;
            },
          ),
          TextFormField(
            initialValue: _phone,
            keyboardType: TextInputType.phone,

            decoration:  InputDecoration(labelText: 'Phone Number',labelStyle :TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w300,
              fontSize: getResponsiveSize(context, fontSize: 17),
              color: AppColors.normGreen,
            ),),
            onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
            onSaved: (value) {
              _phone = value ?? _phone;
            },
          ),
          TextFormField(
            initialValue: _address,
            keyboardType: TextInputType.emailAddress,
            decoration:  InputDecoration(labelText: 'Address',labelStyle: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w300,
              fontSize: getResponsiveSize(context, fontSize: 17),
              color: AppColors.normGreen,
            ),),
            onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your address';
              }
              return null;
            },
            onSaved: (value) {
              _address = value ?? _address;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Navigator.pop(context);
                // Handle the updated information here (e.g., save to database or state)
              }
            },
            child: Text('Save',
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w300,
                fontSize: getResponsiveSize(context, fontSize: 15),
                color: AppColors.normGreen,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}