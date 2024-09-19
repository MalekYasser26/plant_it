import 'package:flutter/material.dart';
import 'package:plant_it/constants/constants.dart';

class PaymentMethodSection extends StatefulWidget {
  const PaymentMethodSection({super.key});

  @override
  State<PaymentMethodSection> createState() => _PaymentMethodSectionState();
}

class _PaymentMethodSectionState extends State<PaymentMethodSection> {
  String? _selectedOption = 'cash';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment method",
          style: TextStyle(
            fontFamily: "Raleway",
            fontWeight: FontWeight.bold,
            fontSize: getResponsiveSize(context, fontSize: 20),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF8F9EF),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            children: [
              // SizedBox(
              //   height: 40,
              //   child: RadioListTile<String>(
              //     fillColor: const WidgetStatePropertyAll(AppColors.darkGreenL),
              //     secondary: Image.asset('assets/images/visa.png',height: 35,width: 35,),
              //     title:  Text('Debit/credit card',
              //       style: TextStyle(
              //         fontFamily: "Poppins",
              //         fontSize:
              //         getResponsiveSize(context, fontSize: 18),
              //         fontWeight: FontWeight.w300,
              //       ),
              //     ),
              //     value: 'visa',
              //     groupValue: _selectedOption,
              //     onChanged: (String? value) {
              //       setState(() {
              //         _selectedOption = value;
              //       });
              //     },
              //     contentPadding:
              //     const EdgeInsets.symmetric(horizontal: 22.0),
              //   ),
              // ),
              RadioListTile<String>(
                fillColor: const WidgetStatePropertyAll(AppColors.darkGreenL),
                secondary: Image.asset('assets/images/cash.png',height: 35,width: 35,),
                title:  Text('Cash on delivery',style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize:
                  getResponsiveSize(context, fontSize: 18),
                  fontWeight: FontWeight.w300,
                ),),
                value: 'cash',
                groupValue: _selectedOption,
                onChanged: (String? value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 22.0),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ],
    );
  }
}
