import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/app_text_style.dart';
import 'package:hungry/core/theme/custom_text.dart';
import 'package:hungry/features/home/widget/Search_View.dart';

class HomeAppbarView extends StatefulWidget {
  const HomeAppbarView({super.key,  this.userImage, required this.userAddress, required this.onChane, required this.search});
  final String? userImage;
  final String userAddress;
  final Function(String) onChane;
  final TextEditingController search;


  @override
  State<HomeAppbarView> createState() => _HomeAppbarViewState();
}

class _HomeAppbarViewState extends State<HomeAppbarView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(18, 12, 18, 0),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
        decoration: BoxDecoration(
          color: Appcolors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Appcolors.black.withValues(alpha: .06),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: Appcolors.background.withValues(alpha: .12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/logo/logo.svg",
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        Appcolors.background,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      "Hungry",
                      style: Textstyle.text18bold.copyWith(
                        color: Appcolors.textDark,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          color: Appcolors.background,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        CustomText(
                          widget.userAddress,
                          style: Textstyle.text12bold.copyWith(
                            color: Appcolors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Appcolors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Appcolors.black.withValues(alpha: .07),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      widget.userImage ?? "",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhmF1KmvBlaYTMo8D7cIpdHgMU6rg4efaD8rCyq0uXPIpY072gkjR5-eNojHiceSPWRRJFADVTb0_F8TL0Zsj3qjy7pKJWQ4iVrmR-2w3scD1sY-2V1ejISO3fSGIIRdjcCZKSRvhOuGd9vHY9JTmTWryAD2Nlre6Ik2FtdTnNUjXUHxfPkLyo6VKFEXQz6/s1015/%D8%B5%D9%88%D8%B1-%D8%A8%D8%B1%D9%88%D9%81%D8%A7%D9%8A%D9%84-%D9%84%D9%84%D8%B4%D8%A8%D8%A7%D8%A8%20(10).jpg",
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                "Ready for your meal?",
                style: Textstyle.text24bold.copyWith(color: Appcolors.textDark),
              ),
            ),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                "Discover and order your favorite food",
                style: Textstyle.text12bold.copyWith(
                  color: Appcolors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 18),
            SearchView(search: widget.search, onChanged: widget.onChane),
          ],
        ),
      ),
    );
  }
}
