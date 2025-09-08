import 'package:flutter/material.dart';
import 'package:formify/constants/app_colors.dart';
import 'package:formify/constants/export.dart';

class FancyAttachedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final IconData icon;

  const FancyAttachedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = kPrimaryColor,
    this.textColor = Colors.black,
    this.icon = Icons.play_arrow,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Pill button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(30),
                right: Radius.circular(0), // flat side to attach circle
              ),
            ),
            child: MyText(
              text: text,
              size: 16,
              weight: FontWeight.bold,
              color: textColor,
            ),
          ),
          // Attached circle
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: kPrimaryColor,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}
