import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/description/presentation/views/widgets/category_container.dart';
import 'package:plant_it/features/description/presentation/views/widgets/plant_images_description.dart';

class DescriptionView extends StatefulWidget {
  const DescriptionView({super.key});

  @override
  _DescriptionViewState createState() => _DescriptionViewState();
}

class _DescriptionViewState extends State<DescriptionView> {
  bool isPressed = false;
  double value = 1;
  List<String> categories =[
    "Swiss cheese",
    "Mexican breadfruit",
    "Split-Leaf Philodendron",
    "Monstera deliciosa",
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.basicallyWhite,
        appBar: AppBar(
          backgroundColor: AppColors.basicallyWhite,
          title: Text(
            "Monstera plant",
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              fontSize: getResponsiveSize(context, fontSize: 18),
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PlantImagesDescriptionWidget(),
              const SizedBox(height: 15,),
              Row(
                children: [
                  Text("EGP ", style: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: getResponsiveSize(context, fontSize: 25),
                    fontWeight: FontWeight.w300,
                  ),),
                  Text("220 ", style: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: getResponsiveSize(context, fontSize: 25),
                    fontWeight: FontWeight.bold,
                  ),),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      isPressed = !isPressed;
                      setState(() {});
                    },
                    icon: isPressed
                        ? Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: getResponsiveSize(context, fontSize: 25),
                    )
                        : Icon(
                      Icons.favorite_border,
                      size: getResponsiveSize(context, fontSize: 25),
                    ),
                  )
                ],
              ),
              RatingStars(
                axis: Axis.horizontal,
                value: value,
                onValueChanged: (v) {
                  setState(() {
                    value = v;
                  });
                },
                starCount: 5,
                starSize: 20,
                maxValue: 5,
                starSpacing: 2,
                valueLabelVisibility: false,
                animationDuration: const Duration(milliseconds: 1000),
                valueLabelPadding:
                const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                valueLabelMargin: const EdgeInsets.only(right: 8),
                starOffColor: Colors.blueGrey.withOpacity(0.5),
                starColor: const Color(0xFFFFCB45),
                angle: 12,
              ),
              const SizedBox(height: 10,),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => const SizedBox(width: 5,),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>  CategoryContainer(text: categories[index]),
                  itemCount: 4,
                ),
              ),
              const SizedBox(height: 10,),
              const Text("Sss"),
            ],
          ),
        ),
      ),
    );
  }
}
