import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/features/auth/widget/login_form_card.dart';
import 'package:hungry/features/auth/widget/login_header.dart';
import 'package:hungry/core/widgets/continue_as_guest_button.dart';
import 'package:hungry/features/auth/data/auth_cubit.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/data/auth_state.dart';
import 'package:hungry/features/auth/view/Signup_view.dart';
import 'package:hungry/features/auth/widget/animated_burger_background.dart';
import 'package:hungry/shared/custom_snack.dart';
import 'package:hungry/root.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final AuthRepo authRepo = AuthRepo();

  void _navigateToSignup() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => SignupView()),
    );
  }

  void _continueAsGuest() {
    authRepo.continueAsGuest();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => Root()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const Root()),
            );
          }
           if (state is LoginError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(customSnackBarerror(state.message));
          }
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: context.read<AuthCubit>().formKey,
            child: Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Appcolors.background, Appcolors.green],
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Appcolors.background, Color(0xFF0F6A35)],
                        ),
                      ),
                    ),
                    AnimatedBurgerBackground(),
                    SafeArea(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 22),
                          child: Column(
                            children: [
                              const SizedBox(height: 40),

                              LoginHeader(),

                              const SizedBox(height: 35),

                              BlocBuilder<AuthCubit, AuthState>(
                                builder: (context, state) {
                                  final Loading = state is LoginLoading;

                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Appcolors.white.withValues(
                                        alpha: .10,
                                      ),
                                      borderRadius: BorderRadius.circular(32),
                                      border: Border.all(
                                        color: Appcolors.white.withValues(
                                          alpha: .15,
                                        ),
                                      ),
                                    ),
                                    child: LoginFormCard(
                                      isLoading: Loading,
                                      onLogin: () {
                                        if (!context
                                            .read<AuthCubit>()
                                            .formKey
                                            .currentState!
                                            .validate()) {
                                          return;
                                        }

                                        context.read<AuthCubit>().login(
                                          email: context
                                              .read<AuthCubit>()
                                              .emailController
                                              .text
                                              .trim(),
                                          password: context
                                              .read<AuthCubit>()
                                              .passwordController
                                              .text
                                              .trim(),
                                        );
                                      },
                                      onSignupTap: _navigateToSignup,
                                      onForgotPassword: () {},
                                      emailController: context
                                          .read<AuthCubit>()
                                          .emailController,
                                      passwordController: context
                                          .read<AuthCubit>()
                                          .passwordController,
                                    ),
                                  );
                                },
                              ),

                              const SizedBox(height: 20),

                              ContinueAsGuestButton(onTap: _continueAsGuest),

                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
