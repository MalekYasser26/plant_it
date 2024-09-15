import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';

class CustAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final bool implyLeading;
  final VoidCallback? methodNeededtoCall;  // Declare as nullable VoidCallback

  CustAppBar({
    super.key,
    required this.text,
    required this.implyLeading,
    this.methodNeededtoCall,  // Optional parameter
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        backgroundColor: AppColors.basicallyWhite,
        scrolledUnderElevation: 0.0,
        leading: implyLeading
            ? IconButton(
            onPressed: () {
              // Call the function if it's provided
              if (methodNeededtoCall != null) {
                methodNeededtoCall!();
              }
              // Pop the screen
              Navigator.pop(context, true);
            },
            icon: const Icon(Icons.arrow_back_ios))
            : const SizedBox.shrink(),
        title: Text(
          text,
          style: const TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
