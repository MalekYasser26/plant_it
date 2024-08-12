import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final kInnerDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.circular(50),
  );

  final kGradientBoxDecoration = BoxDecoration(
    gradient: const LinearGradient(
      colors: [
        AppColors.darkGreen,
        AppColors.darkGreenL,
        AppColors.normGreen,
        AppColors.lightGreen,
        AppColors.lighterGreen,
        AppColors.barelyGreen,
      ],
    ),
    borderRadius: BorderRadius.circular(50),
  );
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 50.0,
      decoration: kGradientBoxDecoration,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: kInnerDecoration,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
            decoration: InputDecoration(
              labelText: "Search for your plant here...",
              labelStyle: TextStyle(
                  fontFamily: "Raleway",
                  fontSize: getResponsiveSize(context, fontSize: 13),
                color: Colors.blueGrey
                  ),
              // enabledBorder: const OutlineInputBorder(
              //   borderRadius: BorderRadius.all(Radius.circular(50)),
              //   borderSide: BorderSide(
              //     color: AppColors.darkGreen,
              //   ),
              // ),
              // focusedBorder: const OutlineInputBorder(
              //   borderRadius: BorderRadius.all(Radius.circular(50)),
              //   borderSide: BorderSide(
              //     color: AppColors.darkGreen,
              //   ),
              // ),
              prefixIcon: Icon(Icons.search,color: Colors.blueGrey,),
              border: InputBorder.none
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(10),
              // ),
            ),
          ),
        ),
      ),
    ) ;


  }
}
