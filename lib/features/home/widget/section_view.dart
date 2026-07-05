

import 'package:flutter/material.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/app_text_style.dart';
import 'package:hungry/core/theme/custom_text.dart';

class Section extends StatefulWidget {
   const Section({super.key, 
     this.title,
     this.action,
  });

  final String? title;
  final String? action;

  @override
  State<Section> createState() => SectionState();
}

class SectionState extends State<Section> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
      ),
      child: Row(
        children: [
          CustomText(
            widget.title ?? "",
            style: Textstyle.text20bold.copyWith(
              color: Appcolors.textDark,
            ),
          ),
          const Spacer(),
          CustomText(
            widget.action ?? "",
            style: Textstyle.text14bold.copyWith(
              color: Appcolors.background,
            ),
          ),
        ],
      ),
    );
  }
}