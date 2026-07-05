import 'package:flutter/material.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/custom_text.dart';
import 'package:hungry/core/theme/app_text_style.dart';

class ButtomOrderView extends StatelessWidget {
  const ButtomOrderView({super.key, required this.text, this.onTap});

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 44,
        width: double.infinity, 
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Appcolors.background.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(16),
        ),
        child: CustomText(
          text,
          style:  Textstyle.text16bold.copyWith(
            color: Appcolors.background,
          ),
        ),
      ),
    );
  }
}


