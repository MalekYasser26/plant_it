import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';

class CustAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final bool implyLeading ;
  const CustAppBar({
    super.key,
    required this.text, required this.implyLeading,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        backgroundColor: AppColors.basicallyWhite,
        scrolledUnderElevation: 0.0,
        leading: implyLeading == true ?IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)) : const SizedBox.shrink(),

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
