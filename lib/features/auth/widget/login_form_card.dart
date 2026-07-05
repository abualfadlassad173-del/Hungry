import 'package:flutter/cupertino.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/app_text_style.dart';
import 'package:hungry/core/theme/custom_text.dart';
import 'package:hungry/core/widgets/ButtomSignLogin_view.dart';
import 'package:hungry/core/widgets/TextForm_view.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginFormCard extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onLogin;
  final VoidCallback onSignupTap;
  final VoidCallback onForgotPassword;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginFormCard({
    super.key,
    required this.isLoading,
    required this.onLogin,
    required this.onSignupTap,
    required this.onForgotPassword,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        color: Appcolors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Appcolors.black.withValues(alpha: 0.12),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomText(
            "Login",
            style: Textstyle.text18bold.copyWith(color: Appcolors.background),
          ),
          const SizedBox(height: 18),
          TextformView(
            isPassword: false,
            hint: "Email",
            controller: emailController,
            colorbackground: Appcolors.white,
            colorborder: Appcolors.background,
            colortextinput: Appcolors.background,
            colortexthint: Appcolors.textHint,
            colorIcon: Appcolors.background,
          ),
          const SizedBox(height: 16),
          TextformView(
            isPassword: true,
            hint: "Password",
            controller: passwordController,
            colorbackground: Appcolors.white,
            colorborder: Appcolors.background,
            colortextinput: Appcolors.background,
            colortexthint: Appcolors.textHint,
            colorIcon: Appcolors.background,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Appcolors.background,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CustomText(
                    "Remember me",
                    style: Textstyle.text12bold.copyWith(
                      color: Appcolors.textSecondary,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onForgotPassword,
                child: CustomText(
                  "Forgot Password?",
                  style: Textstyle.text12bold.copyWith(
                    color: Appcolors.background,
                  ),
                ),
              ),
            ],
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
              text: "Login",
              color: Appcolors.background,
              colorText: Appcolors.white,
              onTap: onLogin,
            ),
          const SizedBox(height: 18),
          Center(
            child: GestureDetector(
              onTap: onSignupTap,
              child: CustomText(
                "Create a new account",
                style: Textstyle.text14bold.copyWith(
                  color: Appcolors.background,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
