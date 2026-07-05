import 'package:flutter/material.dart';
import 'package:hungry/core/theme/custom_text.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/app_text_style.dart';

class CheckoutDetilsView extends StatelessWidget {
  const CheckoutDetilsView({super.key, required this.order, required this.taxes, required this.deliveryFees, required this.totalPrice});
  final String order ,taxes , deliveryFees , totalPrice ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                "Order",
                style: Textstyle.text16bold.copyWith(
                  color: Appcolors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
              CustomText(
                order,
                style: Textstyle.text16bold.copyWith(
                  color: Appcolors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                "Taxes",
                style: Textstyle.text16bold.copyWith(
                  color: Appcolors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
              CustomText(
                taxes,
                style: Textstyle.text16bold.copyWith(
                  color: Appcolors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                "Delivery fees",
                style: Textstyle.text16bold.copyWith(
                  color: Appcolors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
              CustomText(
                deliveryFees,
                style: Textstyle.text16bold.copyWith(
                  color: Appcolors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Divider(),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText("Total", style: Textstyle.text16bold),
              CustomText("\$ $totalPrice", style: Textstyle.text16bold),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                "Estimated delivery time:",
                style: Textstyle.text16bold.copyWith(
                  fontWeight: FontWeight.normal,
                ),
              ),
              CustomText(
                "15 - 30 mins",
                style: Textstyle.text16bold.copyWith(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



