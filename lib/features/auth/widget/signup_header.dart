import 'package:flutter/material.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/app_text_style.dart';
import 'package:hungry/core/theme/custom_text.dart';

class SignupHeader extends StatelessWidget {
  const SignupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Appcolors.white.withValues(alpha: .12),
            ),
            child: const Icon(
              Icons.person_add_rounded,
              size: 50,
              color: Appcolors.white,
            ),
          ),
      
          SizedBox(height: 24),
      
          CustomText(
            "Create Account",
            style: Textstyle.text28bold.copyWith(color: Colors.white),
          ),
      
          SizedBox(height: 10),
      
          CustomText(
            "Join us and enjoy delicious burgers anytime",
            textAlign: TextAlign.center,
            style: Textstyle.text14bold.copyWith(
              color: Appcolors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
