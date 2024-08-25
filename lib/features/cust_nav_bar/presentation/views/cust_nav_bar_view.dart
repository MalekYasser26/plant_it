import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavBar({required this.currentIndex, required this.onTap});

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomNavBarClipper(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        color: AppColors.darkGreen, // Background color of the navbar
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(icon: Icons.person, index: 0),
            _buildNavItem(icon: Icons.home_filled, index: 1),
            _buildNavItem(icon: Icons.favorite, index: 2),
            _buildNavItem(icon: Icons.shopping_cart, index: 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required int index}) {
    bool isSelected = widget.currentIndex == index;

    return GestureDetector(
      onTap: () {
        widget.onTap(index);
      },
      child: Container(
        decoration: isSelected
            ? BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4), // Shadow color
              spreadRadius: 1,
              blurRadius: 15,
              offset: const Offset(0, 4), // Shadow position
            ),
          ],
        )
            : null, // No shadow when the icon is not selected
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.white70,
          size: isSelected
              ? getResponsiveSize(context, fontSize: 30)
              : getResponsiveSize(context, fontSize: 24),
        ),
      ),
    );
  }
}

class CustomNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Move to the starting point at (0, 40)
    path.moveTo(0, 40);

    // First curve with increased curve effect
    path.quadraticBezierTo(0, 0, 40, 0);

    // Top straight line
    path.lineTo(size.width - 40, 0);

    // Second curve with increased curve effect
    path.quadraticBezierTo(size.width, 0, size.width, 40);

    // Right vertical line down to the bottom-right corner
    path.lineTo(size.width, size.height);

    // Bottom horizontal line
    path.lineTo(0, size.height);

    // Close the path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
