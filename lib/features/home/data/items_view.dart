import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/app_text_style.dart';
import 'package:hungry/core/theme/custom_text.dart';

class ViewItems extends StatelessWidget {
  const ViewItems({
    super.key,
    required this.name,
    required this.desc,
    required this.image,
    required this.rate,
    required this.onTap,
  });

  final String name;
  final String desc;
  final String image;
  final String rate;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 36,
          right: 36,
          top: 110,
          child: Container(
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Appcolors.black.withValues(alpha: 0.22),
                  blurRadius: 18,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: onTap,
            child: Ink(
              decoration: BoxDecoration(
                color: Appcolors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Appcolors.black.withValues(alpha: .06),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Stack(
                  children: [
                    Positioned(
                      right: 10,
                      bottom: 5,
                      child: GestureDetector(
                        child: Container(
                          height: 38,
                          width: 38,
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: .08),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.favorite_rounded,
                            color: Colors.redAccent,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Appcolors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icon/star.svg",
                              height: 12,
                            ),
                            const SizedBox(width: 4),
                            CustomText(rate, style: Textstyle.text12bold),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 95,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Appcolors.background.withValues(alpha: .15),
                                    Appcolors.surfaceVariant,
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 15,
                              child: Container(
                                width: 62,
                                height: 12,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Appcolors.black.withValues(
                                        alpha: 0.5,
                                      ),
                                      blurRadius: 15,
                                      spreadRadius: 0.5,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Hero(
                                tag: image,
                                child: Image.network(
                                  image,
                                  height: 80,
                                  fit: BoxFit.contain,
                                  filterQuality: FilterQuality.high,
                                  errorBuilder: (_, _, _) {
                                    return Icon(
                                      Icons.fastfood_rounded,
                                      color: Appcolors.background.withValues(
                                        alpha: .5,
                                      ),
                                      size: 55,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 12),

                        CustomText(
                          name,
                          style: Textstyle.text15bold.copyWith(
                            color: Appcolors.textDark,
                          ),
                        ),

                        const SizedBox(height: 4),

                        CustomText(
                          desc,
                          style: Textstyle.text12bold.copyWith(
                            color: Appcolors.textSecondary,
                            fontWeight: FontWeight.w500,
                            height: 1.3,
                          ),
                        ),

                        Spacer(),
                        Container(),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [

                        //     Container(
                        //       height: 38,
                        //       width: 38,
                        //       decoration: BoxDecoration(
                        //         color: Appcolors.background,
                        //         borderRadius: BorderRadius.circular(14),
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Appcolors.background.withValues(
                        //               alpha: .25,
                        //             ),
                        //             blurRadius: 10,
                        //             offset: const Offset(0, 5),
                        //           ),
                        //         ],
                        //       ),
                        //       child: const Icon(
                        //         Icons.add_rounded,
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
