import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/app_text_style.dart';
import 'package:hungry/core/theme/custom_text.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Appcolors.background.withValues(alpha: .25),
                    blurRadius: 80,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),

            Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Appcolors.white.withValues(alpha: .12),
                border: Border.all(
                  color: Appcolors.white.withValues(alpha: .15),
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  "assets/logo/logo.svg",
                  colorFilter: const ColorFilter.mode(
                    Appcolors.white,
                    BlendMode.srcIn,
                  ),
                  height: 50,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 30),

        CustomText(
          "Welcome Back 🍔",
          style: Textstyle.text28bold.copyWith(
            color: Appcolors.white,
            fontSize: 32,
            letterSpacing: .5,
          ),
        ),

        const SizedBox(height: 12),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: CustomText(
            "Fresh burgers, hot meals and fast delivery.\nSign in and enjoy your favorites.",
            textAlign: TextAlign.center,
            style: Textstyle.text14bold.copyWith(
              color: Appcolors.white.withValues(alpha: .75),
              fontWeight: FontWeight.w400,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}