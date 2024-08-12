import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.darkGreen, AppColors.lighterGreen]),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(

        )
      ),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        decoration: InputDecoration(

          labelText: "Search for your plant here...",
          labelStyle: TextStyle(
              fontFamily: "Raleway",
              fontSize: getResponsiveSize(context, fontSize: 13),
              ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(
              color: AppColors.darkGreen,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(
              color: AppColors.darkGreen,
            ),
          ),
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
