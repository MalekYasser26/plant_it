import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:plant_it/features/profile/presentation/views/widgets/edit_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HiBrunoSection extends StatefulWidget {
  const HiBrunoSection({super.key});

  @override
  State<HiBrunoSection> createState() => _HiBrunoSectionState();
}

class _HiBrunoSectionState extends State<HiBrunoSection> {
  String name = '';
  String phoneNum = '';
  String address = '';


  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? '';
      phoneNum = prefs.getString('phoneNum') ?? '';
      address = prefs.getString('address') ?? '';
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              minRadius: 30,
              maxRadius: 40,
              backgroundColor: const Color(0xFF629584),
              child: ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(50),
                child: Text(
                  name.isNotEmpty ? name.characters.first : '',
                  style: const TextStyle(fontFamily: "Poor Story", color: AppColors.basicallyWhite, fontSize: 30),
                ),
              ),
            ),

            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(0.0).copyWith(
                  bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Hi $name! ",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: getResponsiveSize(context, fontSize: 18),
                            ),
                            softWrap: true,
                          ),
                        ),
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
        ),
        const SizedBox(height: 15,),
        Column(
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
                "Phone number: $phoneNum",
                style: TextStyle(
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.w300,
                  fontSize: getResponsiveSize(context, fontSize: 15),
                ),
              ),
            ),
            Text(
              "Address: $address",
              style: TextStyle(
                fontFamily: "Raleway",
                fontWeight: FontWeight.w300,
                fontSize: getResponsiveSize(context, fontSize: 15),
              ),
              softWrap: true,
            ),
          ],
        ),

      ],
    );
  }


  void _showEditInfoModal(BuildContext context) {
    var pCubit = context.read<ProfileCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileSuccessfulState) {
              pCubit.getRecentlySavedProducts(false);
            }
          },
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
              left: 20,
              right: 20,
              top: 20,
            ),
            child:  EditData(

              loadData: () async {
                final prefs = await SharedPreferences.getInstance();
                setState(() {
                  name = prefs.getString('name') ?? '';
                  phoneNum = prefs.getString('phoneNum') ?? '';
                  address = prefs.getString('address') ?? '';
                });
              }
            ),
          ),
        );
      },
    );
  }
}
