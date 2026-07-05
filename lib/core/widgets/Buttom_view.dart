import 'package:flutter/material.dart';
import 'package:hungry/core/theme/custom_text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/app_text_style.dart';

class Buttom extends StatefulWidget {
  const Buttom({
    super.key,
    required this.onTap,
    required this.text,
    required this.colorbackground,
    required this.coloricon,
    this.icon, required this.colorborderside,
  });

  final VoidCallback onTap;
  final String text;
  final String? icon;
  final Color colorbackground;
  final Color coloricon;
  final Color colorborderside;

  @override
  State<Buttom> createState() => _ButtomState();
}

class _ButtomState extends State<Buttom> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        alignment: Alignment.center,
        height: 60,
        width: 140,
        decoration: BoxDecoration(
          color: widget.colorbackground,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color:widget.colorborderside, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              widget.text,
              style: Textstyle.text14bold.copyWith(
                color: widget.colorbackground == Appcolors.white ? Appcolors.background : Appcolors.white,
              ),
            ),
            if (widget.icon != null) ...[
              SizedBox(width: 10),
              SvgPicture.asset(widget.icon!, height: 20,color: widget.coloricon,),
            ],
          ],
        ),
      ),
    );
  }
}



