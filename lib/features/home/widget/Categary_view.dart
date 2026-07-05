import 'package:flutter/material.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/app_text_style.dart';
import 'package:hungry/core/theme/custom_text.dart';

class CategoryItem extends StatefulWidget {
  const CategoryItem({super.key});

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  int selectedIndex = 0;

  final List<String> categories = [
    "🍔 All",
    "🍟 Combos",
    "🍗 Chicken",
    "🥤 Drinks",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(bottom: 20, left: 2),
      physics: const BouncingScrollPhysics(),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final bool selected = selectedIndex == index;

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.center,
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
              color: selected ? Appcolors.background : Appcolors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: selected ? Appcolors.background : Appcolors.border,
              ),
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: Appcolors.background.withValues(alpha: 0.22),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : [],
            ),
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: Textstyle.text14bold.copyWith(
                color: selected ? Appcolors.white : Colors.black,
              ),
              child: CustomText(
                categories[index],
                style: selected
                    ? Textstyle.text14bold.copyWith(color: Colors.white)
                    : Textstyle.text14bold.copyWith(
                        color: Appcolors.textSecondary,
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}

