import 'package:flutter/material.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/app_text_style.dart';
import 'package:hungry/core/theme/custom_text.dart';
import 'package:hungry/features/home/widget/Toppings_list_image_View.dart';

class ToppingsListView extends StatefulWidget {
  const ToppingsListView({
    super.key,
    required this.name,
    required this.image,
    required this.isSelected,
    this.onTap,
  });
  final String name;
  final String image;

  final bool isSelected;

  final VoidCallback? onTap;

  @override
  State<ToppingsListView> createState() => _ToppingsListViewState();
}

class _ToppingsListViewState extends State<ToppingsListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Stack(
        children: [
          Positioned.fill(
            top: 30,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              padding: const EdgeInsets.fromLTRB(10, 42, 10, 10),
              decoration: BoxDecoration(
                color: widget.isSelected
                    ? Appcolors.background
                    : Appcolors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: widget.isSelected
                      ? Appcolors.background
                      : Appcolors.border,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.isSelected
                        ? Appcolors.background.withValues(alpha: 0.18)
                        : Appcolors.shadow,
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CustomText(
                      widget.name,
                      style: Textstyle.text10bold.copyWith(
                        color: widget.isSelected
                            ? Appcolors.white
                            : Appcolors.textDark,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Container(
                      height: 22,
                      width: 22,
                      decoration: BoxDecoration(
                        color: widget.isSelected
                            ? Appcolors.white
                            : Appcolors.background,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.isSelected ? Icons.remove : Icons.add,
                        color: widget.isSelected
                            ? Appcolors.background
                            : Appcolors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ToppingsImageView(image: widget.image),
          ),
        ],
      ),
    );
  }
}
