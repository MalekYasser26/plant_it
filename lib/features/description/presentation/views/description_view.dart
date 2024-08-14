import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/cust_nav_bar/presentation/views/cust_nav_bar_selection_view.dart';
import 'package:plant_it/features/cust_nav_bar/presentation/views/cust_nav_bar_view.dart';
import 'package:plant_it/features/description/presentation/views/widgets/category_container.dart';
import 'package:plant_it/features/description/presentation/views/widgets/description_section.dart';
import 'package:plant_it/features/description/presentation/views/widgets/plant_images_description.dart';

class DescriptionView extends StatefulWidget {
  const DescriptionView({super.key});

  @override
  _DescriptionViewState createState() => _DescriptionViewState();
}

class _DescriptionViewState extends State<DescriptionView> {
  bool isPressed = false;
  double value = 1;
  int quantity = 1;
  List<String> categories = [
    "Swiss cheese",
    "Mexican breadfruit",
    "Split-Leaf Philodendron",
    "Monstera deliciosa",
  ];
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.basicallyWhite,
        appBar: AppBar(
          backgroundColor: AppColors.basicallyWhite,
          title: const Text(
            "Monstera plant",
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PlantImagesDescriptionWidget(),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const Text(
                          "EGP ",
                          style: TextStyle(
                            fontFamily: "Raleway",
                            fontSize: 25,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const Text(
                          "220 ",
                          style: TextStyle(
                            fontFamily: "Raleway",
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            isPressed = !isPressed;
                            setState(() {});
                          },
                          icon: isPressed
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 25,
                                )
                              : const Icon(
                                  Icons.favorite_border,
                                  size: 25,
                                ),
                        ),
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
                      valueLabelPadding: const EdgeInsets.symmetric(
                          vertical: 1, horizontal: 8),
                      valueLabelMargin: const EdgeInsets.only(right: 8),
                      starOffColor: Colors.blueGrey.withOpacity(0.5),
                      starColor: const Color(0xFFFFCB45),
                      angle: 12,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 5,
                        ),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            CategoryContainer(text: categories[index]),
                        itemCount: 4,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const DescriptionSection(
                      title: "Description",
                      subfields: [
                        {
                          "header": "Appearance: ",
                          "description":
                              "Monstera deliciosa is known for its large, heart-shaped leaves that develop splits and perforations as they mature. The leaves can grow quite large, reaching up to 3 feet in length in optimal conditions."
                        },
                        {
                          "header": "Soil: ",
                          "description":
                              "Use a well-draining potting mix, such as a peat-based mix with added perlite or orchid bark. This helps to mimic the plant's natural epiphytic growing conditions."
                        },
                        {
                          "header": "Appearance: ",
                          "description":
                              "Monstera deliciosa is known for its large, heart-shaped leaves that develop splits and perforations as they mature. The leaves can grow quite large, reaching up to 3 feet in length in optimal conditions."
                        },
                        {
                          "header": "Growth Habit: ",
                          "description":
                              "This plant is a climbing vine in its natural habitat, using aerial roots to anchor itself to trees. Indoors, it typically requires support, such as a moss pole or trellis, to encourage vertical growth."
                        }
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCDCDC),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          child: Icon(
                            Icons.remove,
                            size: getResponsiveSize(context, fontSize: 15),
                          ),
                          onTap: () {
                            setState(() {
                              if (quantity > 1) {
                                quantity--;
                              }
                            });
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            quantity.toString(),
                            style: TextStyle(
                              fontSize:
                                  getResponsiveSize(context, fontSize: 20),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        InkWell(
                          child: Icon(
                            Icons.add,
                            size: getResponsiveSize(context, fontSize: 15),
                          ),
                          onTap: () {
                            setState(() {
                              quantity++;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: SizedBox(
                      width: getResponsiveSize(context, fontSize: 350),
                      child: ElevatedButton(
                        onPressed: () {
                          print("add to cart");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDCDCDC),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child: Text("Add to cart",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize:
                                    getResponsiveSize(context, fontSize: 18),
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomBottomNavBar(
                currentIndex: 1,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CustNavBarSelectionView(
                      currentIndex: _currentIndex,
                    ),));
                  });
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
