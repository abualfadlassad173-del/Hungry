import 'package:flutter/material.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/app_text_style.dart';
import 'package:hungry/core/theme/custom_text.dart';
import 'package:hungry/features/order/widget/buttom_order_view.dart';

class OrderItemView extends StatelessWidget {
  final String orderImage;
  final String orderCreatedAt;
  final String orderStatus;
  final String orderTotalPrice;

  const OrderItemView({
    super.key,
    required this.orderImage,
    required this.orderCreatedAt,
    required this.orderStatus,
    required this.orderTotalPrice,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      color: Appcolors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 95,
                  width: 95,
                  decoration: BoxDecoration(
                    color: const Color(0xffFFF1E8),
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Appcolors.background.withValues(alpha: 0.25),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.network(orderImage, fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(width: 25),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        "Food Order",
                        style: Textstyle.text16bold.copyWith(
                          color: Appcolors.textDark,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Appcolors.green.withValues(alpha: .1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: CustomText(
                              orderStatus,
                              style: Textstyle.text12bold.copyWith(
                                color: Appcolors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      CustomText(
                        orderCreatedAt,
                        style: Textstyle.text12bold.copyWith(
                          color: Appcolors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomText(
                        "\$ $orderTotalPrice",
                        style: Textstyle.text18bold.copyWith(
                          color: Appcolors.background,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const ButtomOrderView(text: "Order Again"),
          ],
        ),
      ),
    );
  }
}
