import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/profile/presentation/views/widgets/recently_saved_view.dart';
import 'package:plant_it/features/profile/presentation/views/widgets/saved_item.dart';

class RecentlySavedSection extends StatelessWidget {
  const RecentlySavedSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recently saved",
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                fontSize: getResponsiveSize(context, fontSize: 20),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RecentlySavedView(),));
              },
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.greyish),
              ),
              child: Text(
                "Show all",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w300,
                  fontSize: getResponsiveSize(context, fontSize: 15),
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 100,  // Set a fixed height for the ListView
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return IntrinsicWidth(child: SavedItem(index: index + 1));
            },
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemCount: 6,
          ),
        ),
      ],
    );
  }
}
