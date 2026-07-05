import 'package:flutter/material.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/app_text_style.dart';
import 'package:hungry/core/theme/custom_text.dart';

class SignupFooter extends StatelessWidget {
  final VoidCallback onContinueAsGuest;
  const SignupFooter({super.key, required this.onContinueAsGuest});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 28),
      child: GestureDetector(
        onTap: onContinueAsGuest,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
            color: Appcolors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Appcolors.white.withValues(alpha: 0.18)),
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
