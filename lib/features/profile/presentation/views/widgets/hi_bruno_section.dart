import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart'; // Add this import
import 'dart:io'; // For working with file system paths
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:plant_it/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:plant_it/features/profile/presentation/views/widgets/edit_data.dart';

class HiBrunoSection extends StatefulWidget {
  const HiBrunoSection({super.key});

  @override
  State<HiBrunoSection> createState() => _HiBrunoSectionState();
}

class _HiBrunoSectionState extends State<HiBrunoSection> {
  File? _image; // Store the selected image here
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    var sCubit = context.read<AuthCubit>();

    return Row(
      children: [
        InkWell(
          onTap: () {
            _pickImage(); // Open image picker
          },
          child: Stack(
            children: [
              CircleAvatar(
                minRadius: 30,
                maxRadius: 40,
                child: ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(50),
                  child: _image != null
                      ? Image.file(_image!, fit: BoxFit.cover)
                      : Image.asset('assets/images/bruno.png'), // Default image if no image is selected
                ),
              ),
              const Positioned(
                right: 0,
                bottom: 0,
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.black,
                ),
              ),
            ],
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

  // Function to pick image from the gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Save the selected image
      });
    }
  }

  void _showEditInfoModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileSuccessfulState) {
              setState(() {}); // Trigger UI refresh after a successful update
            }
          },
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
              left: 20,
              right: 20,
              top: 20,
            ),
            child: const EditData(),
          ),
        );
      },
    );
  }
}
