import 'package:flutter/material.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/app_text_style.dart';
import 'package:hungry/core/theme/custom_text.dart';
import 'package:hungry/features/cart/widget/Remove_Buttom_View.dart';
import 'package:hungry/features/cart/data/count_Icon_view.dart';

class CartItemView extends StatelessWidget {
  const CartItemView({
    super.key,
    required this.image,
    required this.name,
    required this.description,
    this.onAdd,
    this.onMun,
    this.onRemove,
    required this.number,
    required this.isLoading,
  });

  final String image;
  final String name;
  final String description;
  final VoidCallback? onAdd;
  final VoidCallback? onMun;
  final VoidCallback? onRemove;
  final int number;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: RepaintBoundary(
        child: Card(
          color: Appcolors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
            side: const BorderSide(color: Appcolors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 112,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Appcolors.surfaceVariant,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            bottom: 6,
                            left: 24,
                            right: 24,
                            child: Container(
                              height: 8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                    color: Appcolors.black.withValues(
                                      alpha: 0.18,
                                    ),
                                    blurRadius: 14,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Image.network(
                            image,
                            width: 92,
                            height: 92,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        name,
                        style: Textstyle.text14bold.copyWith(
                          color: Appcolors.textDark,
                        ),
                      ),
                      CustomText(
                        description,
                        style: Textstyle.text10bold.copyWith(
                          color: Appcolors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: SizedBox(
                    height: 142,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CountIconView(icon: Icons.remove, onpTap: onMun),
                            const Spacer(),
                            CustomText(
                              number.toString(),
                              style: Textstyle.text16bold.copyWith(
                                color: Appcolors.textDark,
                              ),
                            ),
                            const Spacer(),
                            CountIconView(icon: Icons.add, onpTap: onAdd),
                          ],
                        ),
                        const Spacer(),
                        RemoveButtomView(
                          onRemove: onRemove,
                          isLoading: isLoading,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
