import 'package:flutter/material.dart';
import 'package:hungry/core/theme/app_colors.dart';

class CountIconView extends StatelessWidget {
  const CountIconView({super.key, this.onpTap, required this.icon});
  final VoidCallback? onpTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpTap,
      child: Container(
        alignment: Alignment.center,
        height: 34,
        width: 34,
        decoration: BoxDecoration(
          color: Appcolors.background,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Appcolors.background.withValues(alpha: 0.18),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Appcolors.white,
          size: 18,
        ),
      ),
    );
  }
}
