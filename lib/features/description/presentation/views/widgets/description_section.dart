import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';

class DescriptionSection extends StatelessWidget {
  final String title;
  final List<Map<String, String>> subfields;

  const DescriptionSection({
    super.key,
    required this.title,
    required this.subfields,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:  TextStyle(
            fontFamily: "Poppins",
            fontSize: getResponsiveSize(context,fontSize: 22),
            fontWeight: FontWeight.bold,
            color: AppColors.darkGreen,
          ),
        ),
        const SizedBox(height: 10),
        ...List.generate(subfields.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: subfields[index]['header'] ?? '',
                    style:  TextStyle(
                      fontFamily: "Raleway",
                      fontSize: getResponsiveSize(context, fontSize: 18),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: subfields[index]['description'] ?? '',
                    style:  TextStyle(
                      fontFamily: "Raleway",
                      fontSize: getResponsiveSize(context, fontSize: 16),
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
