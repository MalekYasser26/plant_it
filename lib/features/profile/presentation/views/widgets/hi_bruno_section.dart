import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:plant_it/features/profile/presentation/views/widgets/edit_data.dart';

class HiBrunoSection extends StatelessWidget {
  const HiBrunoSection({super.key});

  @override
  Widget build(BuildContext context) {
    var sCubit = context.read<AuthCubit>();
    return Row(
      children: [
        CircleAvatar(
          minRadius: 30,
          maxRadius: 40,
          child: ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(50),
              child: Image.asset('assets/images/bruno.png')),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(0.0).copyWith(
              bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Hi ${sCubit.name}! ",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: getResponsiveSize(context, fontSize: 18),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        _showEditInfoModal(context);
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void _showEditInfoModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
            left: 20,
            right: 20,
            top: 20,
          ),
          child: const EditData(),
        );
      },
    );
  }
}
