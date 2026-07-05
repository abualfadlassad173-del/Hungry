import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/app_text_style.dart';
import 'package:hungry/core/theme/custom_text.dart';
import 'package:hungry/core/widgets/Appbar_back.dart';
import 'package:hungry/core/widgets/Guest_view.dart';
import 'package:hungry/features/auth/data/auth_cubit.dart';
import 'package:hungry/features/auth/data/auth_state.dart';
import 'package:hungry/features/cart/data/cart_model.dart';
import 'package:hungry/features/cart/widget/buttom_Check_view.dart';
import 'package:hungry/features/home/data/cubit/home_cubit.dart';
import 'package:hungry/features/home/data/cubit/home_state.dart';
import 'package:hungry/features/cart/data/Side_options_List_view.dart';
import 'package:hungry/features/home/data/Toppings_List_View.dart';
import 'package:hungry/features/home/widget/card_product_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductDetilsView extends StatefulWidget {
  const ProductDetilsView({
    super.key,
    required this.image,
    required this.productId,
    required this.name,
    required this.desc,
    required this.totalprice,
  });
  final String? name;
  final String? desc;
  final String? image;
  final String totalprice;
  final int productId;
  @override
  State<ProductDetilsView> createState() => _ProductDetilsViewState();
}

class _ProductDetilsViewState extends State<ProductDetilsView> {
  double spicyLevel = 0.5;
  List<int> isSelectedOption = [];
  List<int> isSelectedTopping = [];

  @override
  void initState() {
    super.initState();
    final cubit = context.read<HomeCubit>();
    cubit.getToppings();
    cubit.getSideOptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, State) {
        final cubitAuth = context.read<AuthCubit>();
        if (cubitAuth.isGuest == false) {
          return BlocConsumer<HomeCubit, HomeState>(
            listener: (BuildContext context, state) {},
            builder: (BuildContext context, state) {
              final cubit = context.read<HomeCubit>();
              return Skeletonizer(
                enabled:
                    state is GetToppingsLoading ||
                    state is GetSideOptionsLoading,
                child: BlocListener<HomeCubit, HomeState>(
                  listener: (BuildContext context, state) {
                    if (state is AddToCartSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 1200),
                          content: Text("🎉 Added to Cart Successfully"),
                          backgroundColor: Appcolors.background,
                        ),
                      );
                      Future.delayed(const Duration(seconds: 1), () {
                        Navigator.pop(context);
                      });
                    }
                    if (state is AddToCartError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 1200),
                          content: Text("Failed to add to cart"),
                          backgroundColor: Appcolors.background,
                        ),
                      );
                    }
                  },
                  child: Scaffold(
                    backgroundColor: Appcolors.surface,
                    bottomNavigationBar: Container(
                      height: 96,
                      decoration: BoxDecoration(
                        color: Appcolors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Appcolors.black.withValues(alpha: 0.10),
                            blurRadius: 24,
                            offset: const Offset(0, -8),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                "Total",
                                style: Textstyle.text14bold.copyWith(
                                  color: Appcolors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              CustomText(
                                "\$ ${widget.totalprice}",
                                style: Textstyle.text20bold.copyWith(
                                  color: Appcolors.textDark,
                                ),
                              ),
                            ],
                          ),
                          ButtomCheckView(
                            isLoading: state is AddToCartLoading,
                            text: "Add to Cart",
                            onTap: () => cubit.addToCart(
                              cartData: CartRequestModel(
                                items: [
                                  CartModel(
                                    productid: widget.productId,
                                    Spicy: spicyLevel,
                                    Toppings: isSelectedTopping,
                                    sideOptions: isSelectedOption,
                                    quantity: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    appBar: AppbarBack(
                      background: Appcolors.surface,
                      onTap: () => Navigator.pop(context),
                    ),
                    body: CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CardProductView(
                                  name: widget.name,
                                  desc: widget.desc,
                                  image: widget.image,
                                  valueSpicy: spicyLevel,
                                  onChangeSpicy: (value) =>
                                      setState(() => spicyLevel = value),
                                ),
                                const SizedBox(height: 26),
                                CustomText(
                                  "Toppings",
                                  style: Textstyle.text18bold.copyWith(
                                    color: Appcolors.textDark,
                                  ),
                                ),
                                SizedBox(
                                  height: 142,
                                  child: cubit.Toppings == null
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: Appcolors.background,
                                          ),
                                        )
                                      : ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 18,
                                          ),
                                          itemCount: cubit.Toppings?.length,
                                          itemBuilder: (context, index) {
                                            final topping =
                                                cubit.Toppings![index];
                                            final id = topping.id;
                                            final isSelected = isSelectedTopping
                                                .contains(id);
                                            return ToppingsListView(
                                              name: topping.name,
                                              image: topping.image,
                                              isSelected: isSelected,
                                              onTap: () {
                                                setState(() {
                                                  if (isSelected) {
                                                    isSelectedTopping.removeAt(
                                                      id,
                                                    );
                                                  } else {
                                                    isSelectedTopping.add(id);
                                                  }
                                                });
                                              },
                                            );
                                          },
                                        ),
                                ),
                                const SizedBox(height: 20),
                                CustomText(
                                  "Side Options",
                                  style: Textstyle.text18bold.copyWith(
                                    color: Appcolors.textDark,
                                  ),
                                ),
                                SizedBox(
                                  height: 142,
                                  child: cubit.SideOptions == null
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 18,
                                          ),
                                          itemCount: cubit.SideOptions?.length,
                                          itemBuilder: (context, index) {
                                            final option =
                                                cubit.SideOptions?[index];
                                            final id = option?.id ?? 0;
                                            final isSelected = isSelectedOption
                                                .contains(id);
                                            return SideOptionsListView(
                                              name: option!.name,
                                              image: option.image,
                                              isSelected: isSelected,
                                              onTap: () {
                                                setState(() {
                                                  if (isSelected) {
                                                    isSelectedOption.removeAt(
                                                      id,
                                                    );
                                                  } else {
                                                    isSelectedOption.add(id);
                                                  }
                                                });
                                              },
                                            );
                                          },
                                        ),
                                ),
                                const SizedBox(height: 110),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        return Skeletonizer(
          enabled: State is AutoLoginLoading,
          child: GuestView(
            title: "Sign in to for add to your cart",
            description: "Please sign in to add to your cart",
          ),
        );
      },
    );
  }
}
