import 'package:flutter/material.dart';
import 'package:hungry/core/theme/custom_text.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/app_text_style.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RemoveButtomView extends StatelessWidget {
  const RemoveButtomView({super.key, this.onRemove, required this.isLoading});

  final VoidCallback? onRemove;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onRemove,
      child: Container(
        width: double.infinity,
        height: 42,
        decoration: BoxDecoration(
          color: Appcolors.background.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: isLoading
            ? LoadingAnimationWidget.staggeredDotsWave(
                color: Appcolors.background,
                size: 24,
              )
            : CustomText(
                "Remove",
                style: Textstyle.text14bold.copyWith(
                  color: Appcolors.background,
                ),
              ),
      ),
    );
  }
}
