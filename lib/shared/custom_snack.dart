import 'package:flutter/material.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/custom_text.dart';

SnackBar customSnackBarerror(String e) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    backgroundColor: Appcolors.error,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    content: Row(
      children: [
        const Icon(Icons.error_outline_rounded, color: Colors.white),
        const SizedBox(width: 12),
        Expanded(
          child: CustomText(
            e.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

SnackBar customSnackBarSuccess(String e) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    backgroundColor: Colors.green,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    content: Row(
      children: [
        const Icon(Icons.check, color: Colors.white),
        const SizedBox(width: 12),
        Expanded(
          child: CustomText(
            e.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}
