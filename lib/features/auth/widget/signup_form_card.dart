import 'package:flutter/material.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/app_text_style.dart';
import 'package:hungry/core/theme/custom_text.dart';
import 'package:hungry/core/widgets/ButtomSignLogin_view.dart';
import 'package:hungry/core/widgets/TextForm_view.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignupFormCard extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onSignup;
  final VoidCallback onSwitchToLogin;

  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController password;

  const SignupFormCard({
    super.key,
    required this.isLoading,
    required this.onSignup,
    required this.onSwitchToLogin,
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Appcolors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Appcolors.black.withValues(alpha: 0.08),
            blurRadius: 28,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 22),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: Appcolors.background.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 22),
            CustomText(
              'Your details',
              style: Textstyle.text20bold.copyWith(color: Appcolors.background),
            ),
            const SizedBox(height: 10),
            CustomText(
              'Fill the form below and start ordering delicious meals.',
              style: Textstyle.text14bold.copyWith(
                color: Appcolors.textSecondary,
                height: 1.6,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TextformView(
              hint: 'Name',
              controller: name,
              isPassword: false,
              colorbackground: Appcolors.white.withValues(alpha: 0.98),
              colorborder: Appcolors.black.withValues(alpha: 0.08),
              colortextinput: Appcolors.background,
              colortexthint: Appcolors.textHint,
              colorIcon: Appcolors.background,
            ),
            const SizedBox(height: 16),
            TextformView(
              hint: 'Email',
              controller: email,
              isPassword: false,
              colorbackground: Appcolors.white.withValues(alpha: 0.98),
              colorborder: Appcolors.black.withValues(alpha: 0.08),
              colortextinput: Appcolors.background,
              colortexthint: Appcolors.textHint,
              colorIcon: Appcolors.background,
            ),
            const SizedBox(height: 16),
            TextformView(
              hint: 'Password',
              controller: password,
              isPassword: true,
              colorbackground: Appcolors.white.withValues(alpha: 0.98),
              colorborder: Appcolors.black.withValues(alpha: 0.08),
              colortextinput: Appcolors.background,
              colortexthint: Appcolors.textHint,
              colorIcon: Appcolors.background,
            ),
            const SizedBox(height: 24),
            if (isLoading)
              Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Appcolors.background,
                  size: 24,
                ),
              )
            else
              ButtomsignloginView(
                text: 'Sign Up',
                color: Appcolors.background,
                colorText: Appcolors.white,
                onTap: onSignup,
              ),
            const SizedBox(height: 14),
            TextButton(
              onPressed: onSwitchToLogin,
              child: CustomText(
                'Already have an account? Login',
                style: Textstyle.text14bold.copyWith(
                  color: Appcolors.background,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
