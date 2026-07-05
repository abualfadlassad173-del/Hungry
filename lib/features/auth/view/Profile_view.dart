import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/widgets/Guest_view.dart';
import 'package:hungry/features/auth/data/auth_cubit.dart';
import 'package:hungry/features/auth/data/auth_state.dart';
import 'package:hungry/features/auth/view/login_view.dart';
import 'package:hungry/features/auth/widget/profile_bottom.dart';
import 'package:hungry/core/theme/custom_text.dart';
import 'package:hungry/features/auth/widget/profile_card.dart';
import 'package:hungry/features/auth/widget/profile_info_card.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/data/user_model.dart';
import 'package:hungry/shared/custom_snack.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController visa = TextEditingController();
  final TextEditingController deliveryAddress = TextEditingController();
  String selectedPaymentMethod = "Visa";
  bool _firstTime = true;
  bool isLoadingLogout = false;
  UserModel? userModel;
  AuthRepo authRepo = AuthRepo();

  /// logout
  Future<void> logout() async {
    if (!mounted) return;
    setState(() => isLoadingLogout = true);
    await authRepo.logout();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
    );
    setState(() => isLoadingLogout = false);
  }

  @override
  void initState() {
    if (!mounted) return;
    if (_firstTime) {
      _firstTime = false;
      final cubit = context.read<AuthCubit>();
      cubit.autoLogin();
      cubit.getProfileData();

      name.text = cubit.userModel?.name ?? '';
      email.text = cubit.userModel?.email ?? '';
      deliveryAddress.text = cubit.userModel?.address ?? '';
    }
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    visa.dispose();
    deliveryAddress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<AuthCubit>();
    if (cubit.state is AutoLoginLoading) {
      return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final cubit = context.read<AuthCubit>();
          return RefreshIndicator(
            displacement: 60,
            color: Appcolors.background,
            backgroundColor: Appcolors.white,
            onRefresh: () async {
              await cubit.getProfileData();
            },
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Scaffold(
                extendBody: true,
                resizeToAvoidBottomInset: true,
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  title: CustomText(
                    'PROFILE',
                    style: TextStyle(
                      color: Appcolors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/icon/settings.svg',
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          Appcolors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
                backgroundColor: Appcolors.background,
                body: Skeletonizer(
                  enabled: cubit.state is AutoLoginLoading,
                  child: Form(
                    key: formKey,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Appcolors.background, Color(0xFF0A3B1F)],
                        ),
                      ),
                      child: SafeArea(
                        child: SingleChildScrollView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.manual,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ProfileCard(
                                onEditImage: cubit.pickImage,
                                name: userModel?.name ?? '',
                                subtitle:
                                    'Keep your profile up to date for a better experience.',
                                selectedImage: cubit.selectedImage,
                                imageUrl: userModel?.image,
                              ),
                              SizedBox(height: 24),
                              ProfileInfoCard(
                                nameController: name,
                                emailController: email,
                                deliveryAddressController: deliveryAddress,
                                passwordController: password,
                                numberVisa: userModel?.visa,
                                selectedPaymentMethod: selectedPaymentMethod,
                                onPaymentMethodChanged: (value) {
                                  setState(() {
                                    selectedPaymentMethod = value;
                                  });
                                },
                                visaController: visa,
                                isVisa: userModel?.visa == null ? true : false,
                              ),
                              const SizedBox(height: 100),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    if (cubit.isGuest) {
      return GuestView(
        title: 'Your profile is waiting',
        description: 'Sign in to  for you can see your profile.',
      );
    }
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is UpdateProfileError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(customSnackBarerror(state.message));
        }
        if (state is UpdateProfileSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(customSnackBarSuccess("Profile updated successfully"));
        }
      },
      builder: (BuildContext context, AuthState state) {
        final cubit = context.read<AuthCubit>();
        return RefreshIndicator(
          displacement: 60,
          color: Appcolors.background,
          backgroundColor: Appcolors.white,
          onRefresh: () async {
            await cubit.getProfileData();
          },
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              extendBody: true,
              resizeToAvoidBottomInset: true,
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                scrolledUnderElevation: 0,
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      'assets/icon/settings.svg',
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        Appcolors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
              backgroundColor: Appcolors.background,
              body: Form(
                key: formKey,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Appcolors.background, Color(0xFF0A3B1F)],
                    ),
                  ),
                  child: SafeArea(
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.manual,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 24,
                      ),
                      child: Skeletonizer(
                        enabled: cubit.state is AutoLoginLoading,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                final userModel = context
                                    .read<AuthCubit>()
                                    .userModel;
                                return ProfileCard(
                                  onEditImage: cubit.pickImage,
                                  name: userModel?.name ?? '',
                                  subtitle:
                                      'Keep your profile up to date for a better experience.',
                                  selectedImage: cubit.selectedImage,
                                  imageUrl: userModel?.image,
                                );
                              },
                            ),

                            const SizedBox(height: 24),

                            ProfileInfoCard(
                              nameController: name,
                              emailController: email,
                              deliveryAddressController: deliveryAddress,
                              passwordController: password,
                              numberVisa: userModel?.visa,
                              selectedPaymentMethod: selectedPaymentMethod,
                              onPaymentMethodChanged: (value) {
                                setState(() {
                                  selectedPaymentMethod = value;
                                });
                              },
                              visaController: visa,
                              isVisa: userModel?.visa == null,
                            ),

                            const SizedBox(height: 30),

                            ProfileBottomActions(
                              isLoadingUpdate: state is UpdateProfileLoading,
                              isLoadingLogout: isLoadingLogout,
                              onEditTap: () {
                                cubit.updateProfileData(
                                  name: name.text.trim(),
                                  email: email.text.trim(),
                                  address: deliveryAddress.text.trim(),
                                  imagepath: cubit.selectedImage,
                                  visa: visa.text.isEmpty
                                      ? null
                                      : int.tryParse(visa.text.trim()),
                                );
                              },
                              Logout: logout,
                              isLoadingSkeleton:
                                  cubit.state is AutoLoginLoading,
                            ),
                            const SizedBox(height: 140),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
