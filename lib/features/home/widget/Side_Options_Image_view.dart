import 'package:flutter/material.dart';
import 'package:hungry/core/theme/app_colors.dart';

class SideOptionsImageView extends StatelessWidget {
  const SideOptionsImageView({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      height: 66,
      width: 82,
      decoration: BoxDecoration(
        color: Appcolors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Appcolors.black.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Image.network(image, height: 44),
    );
  }
}
