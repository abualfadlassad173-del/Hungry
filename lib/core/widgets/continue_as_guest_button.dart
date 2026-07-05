import 'package:flutter/material.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/app_text_style.dart';
import 'package:hungry/core/theme/custom_text.dart';

class ContinueAsGuestButton extends StatelessWidget {
  final VoidCallback onTap;

  const ContinueAsGuestButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
            color: Appcolors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Appcolors.white.withValues(alpha: 0.16),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                'Continue as Guest',
                style: Textstyle.text14bold.copyWith(color: Appcolors.white),
              ),
              const SizedBox(width: 10),
              const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Appcolors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
