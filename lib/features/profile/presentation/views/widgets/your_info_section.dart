import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:plant_it/features/profile/presentation/view_model/profile_cubit.dart';

class YourInfoSection extends StatefulWidget {
  const YourInfoSection({super.key});

  @override
  State<YourInfoSection> createState() => _YourInfoSectionState();
}

class _YourInfoSectionState extends State<YourInfoSection> {
  @override
  Widget build(BuildContext context) {
    var sCubit = context.read<AuthCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Your info",
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
            fontSize: getResponsiveSize(context, fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "Phone number: ${sCubit.phoneNum}",
            style: TextStyle(
              fontFamily: "Raleway",
              fontWeight: FontWeight.w300,
              fontSize: getResponsiveSize(context, fontSize: 15),
            ),
          ),
        ),
        Text(
          "Address: ${sCubit.address}",
          style: TextStyle(
            fontFamily: "Raleway",
            fontWeight: FontWeight.w300,
            fontSize: getResponsiveSize(context, fontSize: 15),
          ),
          softWrap: true,
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    // Listen to changes in the ProfileCubit to update this section
    context.read<ProfileCubit>().stream.listen((state) {
      if (state is ProfileSuccessfulState) {
        setState(() {}); // Trigger UI refresh after a successful update
      }
    });
  }
}

