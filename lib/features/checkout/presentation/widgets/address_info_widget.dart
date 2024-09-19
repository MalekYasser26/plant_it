import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:plant_it/features/checkout/presentation/widgets/line_text.dart';

class AddressInfoWidget extends StatelessWidget {
  const AddressInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var sCubit = context.read<AuthCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0,vertical: 5),
          child: Text(
            "Deliver to",
            style: TextStyle(
              fontFamily: "Raleway",
              fontSize:getResponsiveSize(context, fontSize: 15),

              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        LineText(
          icon: Icon(
            Icons.location_on,
            size: getResponsiveSize(context, fontSize: 30),
            color: Colors.grey,
          ),
          text: sCubit.address,
        ),
        const SizedBox(height: 10,),
        LineText(
          icon: Icon(
            Icons.phone,
            size: getResponsiveSize(context, fontSize: 30),
            color: Colors.grey,

          ),
          text: "Phone number: ${sCubit.phoneNum} ",

        ),
        const SizedBox(height: 10,),

      ],
    );
  }
}
