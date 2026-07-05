import 'package:flutter/material.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/app_text_style.dart';
import 'package:hungry/core/theme/custom_text.dart';
import 'package:hungry/core/widgets/TextForm_view.dart';
import 'package:hungry/core/widgets/visa_view.dart';

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.deliveryAddressController,
    required this.passwordController,
    required this.selectedPaymentMethod,
    required this.onPaymentMethodChanged,
    this.numberVisa,
    required this.visaController,
    required this.isVisa,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController deliveryAddressController;
  final TextEditingController passwordController;
  final TextEditingController visaController;
  final String selectedPaymentMethod;
  final ValueChanged<String> onPaymentMethodChanged;
  final String? numberVisa;
  final bool isVisa;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Appcolors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Appcolors.black.withValues(alpha: 0.08),
            blurRadius: 26,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomText(
            'Personal Information',
            style: TextStyle(
              color: Appcolors.background,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18),
          TextformView(
            hint: "Name",
            controller: nameController,
            isPassword: false,
            colorbackground: Appcolors.white.withValues(alpha: 0.98),
            colorborder: Appcolors.white54,
            colortextinput: Appcolors.background,
            colortexthint: Appcolors.textHint,
            colorIcon: Appcolors.background,
          ),
          const SizedBox(height: 18),
          TextformView(
            hint: "Email",
            controller: emailController,
            isPassword: false,
            colorbackground: Appcolors.white.withValues(alpha: 0.98),
            colorborder: Appcolors.white54,
            colortextinput: Appcolors.background,
            colortexthint: Appcolors.textHint,
            colorIcon: Appcolors.background,
          ),
          const SizedBox(height: 18),
          TextformView(
            hint: "Delivery Address",
            controller: deliveryAddressController,
            isPassword: false,
            colorbackground: Appcolors.white.withValues(alpha: 0.98),
            colorborder: Appcolors.white54,
            colortextinput: Appcolors.background,
            colortexthint: Appcolors.textHint,
            colorIcon: Appcolors.background,
          ),
          const SizedBox(height: 18),
          // TextformView(
          //   hint: "Password",
          //   controller: passwordController,
          //   isPassword: true,
          //   colorbackground: Appcolors.white.withValues(alpha: 0.98),
          //   colorborder: Appcolors.white54,
          //   colortextinput: Appcolors.background,
          //   colortexthint: Appcolors.textHint,
          //   colorIcon: Appcolors.background,
          // ),
          // const SizedBox(height: 24),
          Divider(color: Appcolors.grey.withValues(alpha: 0.35), height: 1.2),
          const SizedBox(height: 22),
          CustomText(
            'Payment Method',
            style: TextStyle(
              color: Appcolors.background,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),
          isVisa
              ? TextformView(
                  hint: "ADD VISA CARD",
                  controller: visaController,
                  textInputType: TextInputType.number,
                  isPassword: false,
                  colorbackground: Appcolors.white.withValues(alpha: 0.98),
                  colorborder: Appcolors.white54,
                  colortextinput: Appcolors.background,
                  colortexthint: Appcolors.textHint,
                  colorIcon: Appcolors.background,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    VisaView(
                      height: 90,
                      widthimage: 70,sizetextVisacart: Textstyle.text12bold.copyWith(
                        color: Appcolors.white.withValues(alpha: 0.7),
                      ),
                      sizetextnumvisa: Textstyle.text12bold.copyWith(
                        color: Appcolors.white,
                      ),
                      numberVisa: numberVisa ?? "**** **** **** 1234",
                      onTap: () => onPaymentMethodChanged('visa'),
                      groupValue: selectedPaymentMethod,
                      onChanged: (v) => onPaymentMethodChanged(v!),
                      ActiveVisa: false,
                      creditCard: false,
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
