import 'package:flutter/material.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/app_text_style.dart';
import 'package:hungry/core/theme/custom_text.dart';
import 'package:hungry/features/home/widget/Spicy_Slider_view.dart';

class CardProductView extends StatefulWidget {
  const CardProductView({
    super.key,
    this.image,
    required this.valueSpicy,
    required this.onChangeSpicy,
    this.name,
    this.desc,
  });
  final String? image;
  final String? name;
  final String? desc;
  final double valueSpicy;
  final ValueChanged<double> onChangeSpicy;
  @override
  State<CardProductView> createState() => _CardProductViewState();
}

class _CardProductViewState extends State<CardProductView> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageSize = constraints.maxWidth * 0.52;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Appcolors.white, Appcolors.surfaceVariant],
            ),
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Appcolors.shadow,
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      bottom: 35,
                      left: 20,
                      right: 20,
                      child: Container(
                        height: 14,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: Appcolors.black.withValues(alpha: 0.48),
                              blurRadius: 20,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: imageSize.clamp(170, 230).toDouble(),
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.network(
                            widget.image!,
                            width: imageSize,
                            height: imageSize,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.image_not_supported);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),
              SizedBox(
                width: 156,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      widget.name ?? 'Customize your burger',
                      style: Textstyle.text20bold.copyWith(
                        color: Appcolors.textDark,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomText(
                      widget.desc ??
                          'Adjust spice, toppings and sides for your perfect bite.',
                      style: Textstyle.text12bold.copyWith(
                        color: Appcolors.textSecondary,
                        fontWeight: FontWeight.w500,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 18),
                    CustomText(
                      "Spicy level",
                      style: Textstyle.text12bold.copyWith(
                        color: Appcolors.textDark,
                      ),
                    ),
                    SpicySliderView(
                      spicyLevel: widget.valueSpicy,
                      onChanged: widget.onChangeSpicy,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          CustomText(
                            "Cold",
                            style: Textstyle.text10bold.copyWith(
                              color: Appcolors.textSecondary,
                            ),
                          ),
                          const Spacer(),
                          CustomText(
                            "Hot",
                            style: Textstyle.text10bold.copyWith(
                              color: Appcolors.background,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
