import 'package:flutter/material.dart';
import 'package:hungry/core/theme/custom_text.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/app_text_style.dart';

class ButtomsignloginView extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? colorText;
  final VoidCallback? onTap;

  const ButtomsignloginView({
    super.key,
    required this.text,
    this.onTap,
    this.color,
    this.colorText,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? Appcolors.white;
    final textColor = colorText ?? Appcolors.background;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        alignment: Alignment.center,
        height: 54,
        width: double.infinity,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Appcolors.black.withValues(alpha: 0.08),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
          border: Border.all(
            color: buttonColor == Appcolors.white
                ? Appcolors.black.withValues(alpha: 0.04)
                : buttonColor,
            width: 1,
          ),
        ),
        child: CustomText(
          text,
          style: Textstyle.text16bold.copyWith(color: textColor),
        ),
      ),
    );
  }
}
