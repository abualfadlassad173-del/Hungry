import 'package:flutter/material.dart';
import 'package:hungry/core/theme/custom_text.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/app_text_style.dart';

class ButtomCheckView extends StatelessWidget {
  const ButtomCheckView({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Appcolors.background, Appcolors.backgroundDark],
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Appcolors.background.withValues(alpha: 0.24),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Appcolors.white,
                  ),
                )
              : CustomText(
                  text,
                  style: Textstyle.text14bold.copyWith(color: Appcolors.white),
                ),
        ),
      ),
    );
  }
}
