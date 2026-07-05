import 'package:flutter/material.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/app_text_style.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key, required this.search, required this.onChanged});
  final TextEditingController search;
  final Function(String) onChanged;
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: Appcolors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Appcolors.black.withValues(alpha: .05),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.search,
        onChanged: widget.onChanged,
        style: Textstyle.text14bold.copyWith(color: Appcolors.textDark),
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,

          contentPadding: const EdgeInsets.symmetric(vertical: 16),

          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Appcolors.background,
            size: 28,
          ),

          hintText: "Search burgers, meals...",
          hintStyle: Textstyle.text14bold.copyWith(
            color: Appcolors.textHint,
            fontWeight: FontWeight.w500,
          ),

          suffixIcon: Padding(
            padding: const EdgeInsets.all(7),
            child: Container(
              width: 44,
              decoration: BoxDecoration(
                color: Appcolors.background,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Appcolors.background.withValues(alpha: .25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.tune_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
