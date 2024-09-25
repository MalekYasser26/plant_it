import 'package:flutter/material.dart';
import 'package:plant_it/features/tracking/views/widgets/icons_connection_order_status.dart';
import 'package:plant_it/features/tracking/views/widgets/text_desc_order_status.dart';

class OrderStatus extends StatelessWidget {
  final String text, subtext;

  final bool isCompleted, isLast;

  const OrderStatus({
    super.key,
    required this.text,
    required this.subtext,
    required this.isCompleted,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconsConnectionOrderStatus(isCompleted: isCompleted, isLast: isLast),
        TextDescOrderStatus(
            isCompleted: isCompleted, text: text, subtext: subtext),
      ],
    );
  }
}
