import 'package:flutter/material.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/app_text_style.dart';
import 'package:hungry/core/theme/custom_text.dart';

class VisaView extends StatefulWidget {
  const VisaView({
    super.key,
    this.numberVisa,
    this.onTap,
    required this.groupValue,
    this.onChanged,
    this.height,
    this.widthimage,
    this.sizetextVisacart,
    this.sizetextnumvisa,
    required this.ActiveVisa,
    required this.creditCard,
  });
  final double? height;
  final double? widthimage;
  final TextStyle? sizetextVisacart;
  final TextStyle? sizetextnumvisa;
  final String? numberVisa;
  final Function? onTap;
  final String groupValue;
  final Function? onChanged;
  final bool ActiveVisa;
  final bool creditCard;

  @override
  State<VisaView> createState() => _VisaViewState();
}

class _VisaViewState extends State<VisaView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap?.call(),
      child: Container(
        height: widget.height ?? 120,
        width: double.infinity,
        padding: EdgeInsets.only(left: 15, right: 12, top: 19, bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Appcolors.lightBlue, Appcolors.textHint],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 18,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "assets/image/visa.png",
              width: widget.widthimage ?? 90,
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  "VISA CARD",
                  style:
                      widget.sizetextVisacart ??
                      Textstyle.text14bold.copyWith(
                        color: Appcolors.white.withValues(alpha: 0.7),
                      ),
                ),
                const SizedBox(height: 15),
                CustomText(
                  widget.numberVisa ?? "****  ****  ****  1234",
                  style:
                      widget.sizetextnumvisa ??
                      Textstyle.text10bold.copyWith(
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                ),

                // SizedBox(height: 24),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         CustomText(
                //           "CARD HOLDER",
                //           style: Textstyle.text12bold.copyWith(
                //             color: Appcolors.white.withOpacity(0.7),
                //           ),
                //         ),
                //         SizedBox(height: 6),
                //         CustomText("Fadl Programmer", style: Textstyle.text16bold.copyWith(color: Appcolors.white)),
                //       ],
                //     ),

                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.end,
                //       children: [
                //         CustomText(
                //           "VALID THRU",
                //           style: Textstyle.text12bold.copyWith(
                //             color: Appcolors.white.withOpacity(0.7),
                //           ),
                //         ),
                //         SizedBox(height: 6),
                //         CustomText(
                //           "12/30",
                //           style: Textstyle.text16bold.copyWith(color: Appcolors.white),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
              ],
            ),

            Spacer(),

            widget.ActiveVisa
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      widget.creditCard
                          ? Container(
                              width: 45,
                              height: 35,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.credit_card,
                                color: Colors.white,
                              ),
                            )
                          : SizedBox.shrink(),
                      Spacer(),

                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Radio<String>(
                          activeColor: Appcolors.white,
                          value: "Visa",
                          groupValue: widget.groupValue,
                          onChanged: (value) => widget.onChanged,
                        ),
                      ),
                    ],
                  )
                : Container(
                  height: 30,
                  alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Appcolors.green.withValues(alpha: .4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CustomText(
                      "Default",
                      style: Textstyle.text12bold.copyWith(
                        color: Appcolors.black,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
